import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'stt_service.dart';
import 'tts_service.dart';
import 'local_tts_service.dart';
import 'bhashini_service.dart';
import 'sarvam_service.dart';
import 'elevenlabs_service.dart';
import '../audio/audio_providers.dart'; // Import to access audio player

// ─────────────────────────────────────────────────────────────────────────────
// Voice Provider Selection
// ─────────────────────────────────────────────────────────────────────────────

/// Available voice provider backends.
enum VoiceBackend { mock, local, bhashini, sarvam, elevenLabs }

/// Auto-detects which backend to use based on available API keys in .env.
/// Priority: Bhashini (free, 22 languages) → Sarvam → Local → Mock.
final voiceBackendProvider = Provider<VoiceBackend>((ref) {
  final bhashiniKey = dotenv.env['BHASHINI_API_KEY'] ?? '';
  final bhashiniUser = dotenv.env['BHASHINI_USER_ID'] ?? '';
  final sarvamKey = dotenv.env['SARVAM_API_KEY'] ?? '';
  final elevenLabsKey = dotenv.env['ELEVENLABS_API_KEY'] ?? '';

  // Priority: ElevenLabs (Premium TTS) → Bhashini (Free) → Sarvam (Paid)

  // If ElevenLabs key exists, use it for TTS (STT will still use Sarvam/Bhashini)
  if (elevenLabsKey.isNotEmpty && !elevenLabsKey.startsWith('your-')) {
    debugPrint('SpeechProvider: Using ElevenLabs backend (Hybrid)');
    return VoiceBackend.elevenLabs;
  }

  // Prefer Bhashini if real credentials are set
  if (bhashiniKey.isNotEmpty &&
      bhashiniUser.isNotEmpty &&
      !bhashiniKey.startsWith('your-')) {
    debugPrint('SpeechProvider: Using Bhashini backend');
    return VoiceBackend.bhashini;
  }

  // Fall back to Sarvam if its key is set
  if (sarvamKey.isNotEmpty && !sarvamKey.startsWith('your-')) {
    debugPrint('SpeechProvider: Using Sarvam backend');
    return VoiceBackend.sarvam;
  }

  // No API keys → use local TTS + mock STT
  debugPrint('SpeechProvider: No API keys found, using local/mock backend');
  return VoiceBackend.local;
});

// ─────────────────────────────────────────────────────────────────────────────
// STT Providers
// ─────────────────────────────────────────────────────────────────────────────

/// Provides the active [SttService] based on [voiceBackendProvider].
final sttServiceProvider = Provider<SttService>((ref) {
  final backend = ref.watch(voiceBackendProvider);

  switch (backend) {
    case VoiceBackend.sarvam:
    case VoiceBackend.elevenLabs: // ElevenLabs doesn't have STT, use Sarvam
      final service = SarvamSttService();
      ref.onDispose(() => service.dispose());
      return service;

    case VoiceBackend.bhashini:
      final service = BhashiniSttService();
      ref.onDispose(() => service.dispose());
      return service;

    case VoiceBackend.local:
      // No local STT implementation yet — fall back to Bhashini
      final service = BhashiniSttService();
      ref.onDispose(() => service.dispose());
      return service;

    case VoiceBackend.mock:
      final service = _MockSttService();
      ref.onDispose(() => service.dispose());
      return service;
  }
});

// ─────────────────────────────────────────────────────────────────────────────
// TTS Providers
// ─────────────────────────────────────────────────────────────────────────────

/// Provides the active [TtsService] based on [voiceBackendProvider].
final ttsServiceProvider = Provider<TtsService>((ref) {
  final backend = ref.watch(voiceBackendProvider);
  final audioPlayer = ref.watch(audioPlayerProvider);

  switch (backend) {
    case VoiceBackend.elevenLabs:
      final service = ElevenLabsTtsService();
      // Wire up audio player to play the generated audio
      service.onAudioReady = (base64Audio) async {
        await audioPlayer.playFromBase64(base64Audio);
      };
      ref.onDispose(() => service.dispose());
      return service;

    case VoiceBackend.sarvam:
      final service = SarvamTtsService();
      // Wire up audio player
      service.onAudioReady = (base64Audio) async {
        await audioPlayer.playFromBase64(base64Audio);
      };
      ref.onDispose(() => service.dispose());
      return service;

    case VoiceBackend.bhashini:
      final service = BhashiniTtsService();
      // Wire up audio player
      service.onAudioReady = (base64Audio) async {
        await audioPlayer.playFromBase64(base64Audio);
      };
      ref.onDispose(() => service.dispose());
      return service;

    case VoiceBackend.local:
      final service = LocalTtsService();
      ref.onDispose(() => service.dispose());
      return service;

    case VoiceBackend.mock:
      final service = _MockTtsService();
      ref.onDispose(() => service.dispose());
      return service;
  }
});

/// Convenience: always-available local TTS (for fallback usage).
final localTtsProvider = Provider.autoDispose<LocalTtsService>((ref) {
  final service = LocalTtsService();
  ref.onDispose(() => service.dispose());
  return service;
});

/// Stream provider for TTS state (from whichever backend is active).
final ttsStateProvider = StreamProvider.autoDispose<TtsState>((ref) {
  final tts = ref.watch(ttsServiceProvider);
  return tts.stateStream;
});

// ─────────────────────────────────────────────────────────────────────────────
// Mock Implementations (for development & testing)
// ─────────────────────────────────────────────────────────────────────────────

class _MockSttService implements SttService {
  @override
  Future<TranscriptionResult> transcribe(
    String audioPath,
    String language,
  ) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return TranscriptionResult(
      text: 'Mock transcription — "$audioPath" in $language',
      confidence: 0.95,
      language: language,
      metadata: {'provider': 'mock'},
    );
  }

  @override
  Future<bool> isAvailable() async => true;

  @override
  Future<void> dispose() async {}
}

class _MockTtsService implements TtsService {
  final _stateController = StreamController<TtsState>.broadcast();
  TtsState _currentState = TtsState.idle;

  @override
  Future<void> speak(
    String text,
    String language, {
    double speed = 1.0,
    double pitch = 1.0,
  }) async {
    _currentState = TtsState.speaking;
    _stateController.add(TtsState.speaking);
    await Future.delayed(const Duration(seconds: 2));
    _currentState = TtsState.idle;
    _stateController.add(TtsState.idle);
  }

  @override
  Future<void> stop() async {
    _currentState = TtsState.idle;
    _stateController.add(TtsState.idle);
  }

  @override
  Future<void> pause() async {
    _currentState = TtsState.paused;
    _stateController.add(TtsState.paused);
  }

  @override
  Future<void> resume() async {
    _currentState = TtsState.speaking;
    _stateController.add(TtsState.speaking);
  }

  @override
  Stream<TtsState> get stateStream => _stateController.stream;

  @override
  TtsState get currentState => _currentState;

  @override
  Future<bool> isAvailable() async => true;

  @override
  Future<void> setDefaultSpeed(double speed) async {}

  @override
  Future<void> dispose() async {
    await _stateController.close();
  }
}
