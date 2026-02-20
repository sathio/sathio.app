import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'voice_state.dart';
import '../audio/audio_recorder_service.dart';
import '../audio/audio_player_service.dart';
import '../audio/audio_providers.dart';
import '../speech/stt_service.dart';
import '../speech/tts_service.dart';
import '../speech/speech_providers.dart';
import '../language/language_providers.dart';
import '../network/connectivity_service.dart';
import '../offline/offline_providers.dart';

/// Orchestrates the full voice interaction pipeline:
///
/// ```
/// idle → [mic tap] → listening → [stop/auto-stop]
///   → processing (detect lang → STT → intent → response)
///   → speaking (TTS) → idle
/// ```
///
/// For agentic tasks: processing → executing_action → idle
/// For slot filling: processing → waiting_for_input → listening (loop)
class VoiceInteractionManager extends Notifier<VoiceState> {
  /// Current language code (default: Hindi).
  String _currentLanguage = 'hi';

  /// Last recorded file path.
  String? _lastRecordingPath;

  /// Subscription for recording amplitude.
  StreamSubscription? _amplitudeSub;

  /// Subscription for TTS state.
  StreamSubscription? _ttsSub;

  /// Timer for tracking recording duration.
  Timer? _durationTimer;
  int _recordingSeconds = 0;

  // ── Callbacks (set by UI or providers) ──────────────────────────────────

  /// Called when language is auto-detected and switched.
  void Function(String newLang)? onLanguageChanged;

  /// Called when speech is transcribed.
  void Function(String text)? onTranscriptionComplete;

  /// Called when the bot response is ready.
  void Function(BotResponse response)? onResponseReady;

  /// Called on error.
  void Function(String message)? onError;

  @override
  VoiceState build() {
    // Seed offline content in background
    ref.read(offlineInitializerProvider);
    return const VoiceIdle();
  }

  // ── Helper getters ──────────────────────────────────────────────────────

  AudioRecorderService get _recorder => ref.read(audioRecorderProvider);
  AudioPlayerService get _player => ref.read(audioPlayerProvider);
  SttService get _sttService => ref.read(sttServiceProvider);
  TtsService get _ttsService => ref.read(ttsServiceProvider);

  // ── Public API ──────────────────────────────────────────────────────────

  /// Current language code.
  String get currentLanguage => _currentLanguage;

  /// Set language (e.g., from language picker).
  void setLanguage(String langCode) {
    _currentLanguage = langCode;
    onLanguageChanged?.call(langCode);
  }

  /// Start listening — begins audio recording.
  Future<void> startListening() async {
    if (state is VoiceListening) return; // Already listening

    try {
      await _recorder.startRecording();
      _recordingSeconds = 0;

      state = const VoiceListening();

      // Track recording duration
      _durationTimer?.cancel();
      _durationTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        _recordingSeconds++;
        if (state is VoiceListening) {
          state = (state as VoiceListening).copyWith(
            elapsed: Duration(seconds: _recordingSeconds),
          );
        }
      });

      // Track amplitude for waveform
      _amplitudeSub?.cancel();
      _amplitudeSub = _recorder.amplitudeStream.listen((amp) {
        if (state is VoiceListening) {
          // Normalize amplitude: amp.current is in dB (typically -60 to 0)
          final normalized = ((amp.current + 60) / 60).clamp(0.0, 1.0);
          state = (state as VoiceListening).copyWith(amplitude: normalized);
        }
      });

      debugPrint('VoiceManager: Listening started');
    } catch (e) {
      _handleError('Failed to start recording: $e');
    }
  }

  /// Stop listening — stops recording and begins processing pipeline.
  Future<void> stopListening() async {
    if (state is! VoiceListening) return;

    try {
      _durationTimer?.cancel();
      _amplitudeSub?.cancel();

      final path = await _recorder.stopRecording();
      if (path == null) {
        _handleError('Recording failed — no audio captured');
        return;
      }

      _lastRecordingPath = path;
      debugPrint('VoiceManager: Recording stopped, path: $path');

      // Enter processing pipeline
      await _processRecording(path);
    } catch (e) {
      _handleError('Failed to stop recording: $e');
    }
  }

  /// Cancel listening — discards recording and returns to idle.
  Future<void> cancelListening() async {
    _durationTimer?.cancel();
    _amplitudeSub?.cancel();

    try {
      await _recorder.cancelRecording();
    } catch (_) {}

    state = const VoiceIdle();
    debugPrint('VoiceManager: Listening cancelled');
  }

  /// Speak a response text via TTS.
  Future<void> speakResponse(String text) async {
    final response = BotResponse(
      transcribedText: '',
      responseText: text,
      language: _currentLanguage,
      timestamp: DateTime.now(),
    );

    state = VoiceSpeaking(response: response);

    _ttsSub?.cancel();
    _ttsSub = _ttsService.stateStream.listen((ttsState) {
      if (ttsState == TtsState.idle && state is VoiceSpeaking) {
        state = const VoiceIdle();
      }
    });

    try {
      await _ttsService.speak(text, _currentLanguage);
    } catch (e) {
      debugPrint('VoiceManager: TTS failed: $e');
      state = const VoiceIdle();
    }
  }

  /// Retry the last operation.
  Future<void> retry() async {
    if (_lastRecordingPath != null) {
      await _processRecording(_lastRecordingPath!);
    } else {
      state = const VoiceIdle();
    }
  }

  /// Stop everything and return to idle.
  Future<void> reset() async {
    _durationTimer?.cancel();
    _amplitudeSub?.cancel();
    _ttsSub?.cancel();

    try {
      if (_recorder.isRecording) {
        await _recorder.cancelRecording();
      }
      await _player.stop();
      await _ttsService.stop();
    } catch (_) {}

    state = const VoiceIdle();
  }

  // ── Processing Pipeline ─────────────────────────────────────────────────

  Future<void> _processRecording(String audioPath) async {
    try {
      // Step 1: Detect language
      state = const VoiceProcessing(step: ProcessingStep.detectingLanguage);

      // Auto-detect and switch language if high confidence
      final newLang = await ref
          .read(languageManagerProvider.notifier)
          .autoDetectAndSwitch(audioPath);

      if (newLang != null) {
        _currentLanguage = newLang; // Update local tracker
        onLanguageChanged?.call(newLang); // Notify UI overlay
      }

      // Use current language (which might have just switched)
      final processingLang = ref.read(languageManagerProvider);
      _currentLanguage = processingLang; // Sync just in case

      // Step 2: Transcribe audio → text
      state = const VoiceProcessing(step: ProcessingStep.transcribing);
      debugPrint('VoiceManager: Transcribing in $_currentLanguage...');

      final transcription = await _sttService.transcribe(
        audioPath,
        _currentLanguage,
      );

      if (transcription.isEmpty) {
        _handleError('Could not understand the audio. Please try again.');
        return;
      }

      debugPrint('VoiceManager: Transcribed: "${transcription.text}"');
      onTranscriptionComplete?.call(transcription.text);

      // Check connectivity
      final connectivity = ref.read(connectivityServiceProvider);
      if (!connectivity.isOnline) {
        debugPrint('VoiceManager: Offline mode detected');

        // Offline handling
        final handler = ref.read(offlineQueryHandlerProvider);
        final offlineResponse = await handler.handleQuery(
          transcription.text,
          _currentLanguage,
        );

        String responseText;
        if (offlineResponse != null) {
          responseText = offlineResponse;
          debugPrint('VoiceManager: Found offline answer');
        } else {
          responseText = _currentLanguage == 'hi'
              ? 'Abhi internet nahi hai. Main sirf saved jaankari de sakta hoon.'
              : 'No internet connection. I can only answer saved questions.';
        }

        final botResponse = BotResponse(
          transcribedText: transcription.text,
          responseText: responseText,
          language: _currentLanguage,
          timestamp: DateTime.now(),
        );

        onResponseReady?.call(botResponse);

        // Speak response (local TTS works offline)
        state = VoiceSpeaking(response: botResponse);
        await _ttsService.speak(responseText, _currentLanguage);

        await Future.delayed(const Duration(milliseconds: 500));
        state = const VoiceIdle();
        return;
      }

      // Online: Step 3 - Classify Intent (Placeholder)
      state = const VoiceProcessing(step: ProcessingStep.classifyingIntent);
      await Future.delayed(const Duration(milliseconds: 200));

      // Step 4: Generate response (Placeholder)
      state = const VoiceProcessing(step: ProcessingStep.generatingResponse);
      await Future.delayed(const Duration(milliseconds: 300));

      // Placeholder response — will be replaced with actual AI response
      final responseText =
          'Maine suna: "${transcription.text}". '
          'Abhi main samajh raha hoon... '
          '(AI response will come in Phase 6)';

      // Sample data for UI testing
      final botResponse = BotResponse(
        transcribedText: transcription.text,
        responseText: responseText,
        language: _currentLanguage,
        timestamp: DateTime.now(),
        contextTitle: 'Sathio AI',
        steps: [
          'Step 1: Analyzing your query...',
          'Step 2: Connecting to knowledge base...',
          'Step 3: Generating answer...',
        ],
        isActionable: true,
      );

      onResponseReady?.call(botResponse);

      // Step 5: Speak the response via TTS
      state = VoiceSpeaking(response: botResponse);

      _ttsSub?.cancel();
      _ttsSub = _ttsService.stateStream.listen((ttsState) {
        if (ttsState == TtsState.idle && state is VoiceSpeaking) {
          state = const VoiceIdle();
        }
      });

      await _ttsService.speak(responseText, _currentLanguage);

      // If TTS completes synchronously (e.g., local TTS)
      if (state is VoiceSpeaking) {
        await Future.delayed(const Duration(milliseconds: 500));
        if (state is VoiceSpeaking) {
          state = const VoiceIdle();
        }
      }
    } on SttException catch (e) {
      _handleError('Speech recognition failed: ${e.message}');
    } catch (e) {
      _handleError('Processing failed: $e');
    }
  }

  // ── Error Handling ──────────────────────────────────────────────────────

  void _handleError(String message) {
    debugPrint('VoiceManager ERROR: $message');
    state = VoiceError(message: message);
    onError?.call(message);
  }
}
