import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/voice/voice_state.dart';
import '../../services/voice/voice_providers.dart'; // Correct import for provider
import '../../services/speech/tts_service.dart';
import '../../services/speech/speech_providers.dart';

class ResponseState {
  final BotResponse? response;
  final TtsState ttsState;
  final double speed;

  ResponseState({
    this.response,
    this.ttsState = TtsState.idle,
    this.speed = 1.0,
  });

  factory ResponseState.initial() {
    return ResponseState();
  }

  ResponseState copyWith({
    BotResponse? response,
    TtsState? ttsState,
    double? speed,
  }) {
    return ResponseState(
      // null response means keep existing? Or clear?
      // Using ?? so if null is passed, we check if it was explicitly null or just omitted?
      // For simple copyWith, we usually assume non-null input means update.
      // But here response can be nullable.
      // Let's assume passed argument is what we want.
      response: response ?? this.response,
      ttsState: ttsState ?? this.ttsState,
      speed: speed ?? this.speed,
    );
  }
}

class ResponseController extends Notifier<ResponseState> {
  @override
  ResponseState build() {
    _setupListeners();

    // Check if we are already speaking (seed initial state)
    final voiceState = ref.read(voiceInteractionProvider);
    if (voiceState is VoiceSpeaking) {
      return ResponseState(
        response: voiceState.response,
        ttsState: TtsState.speaking,
      );
    }

    return ResponseState.initial();
  }

  void _setupListeners() {
    // Listen to TTS State
    final ttsStateAsync = ref.read(
      ttsStateProvider,
    ); // Initial read? No, want stream.
    // Provider listening in build() is tricky with side-effects in Notifier.
    // Better to use ref.listen manually if we are outside build, but inside build we can just watch?
    // But we need to update OUR state based on OTHER providers.
    // In Notifier, we can use ref.listen in build?
    // Actually, best practice:
    // ref.listen(ttsStateProvider, ...)

    // Listen for TTS changes
    ref.listen(ttsStateProvider, (previous, next) {
      next.whenData((ttsState) {
        state = state.copyWith(ttsState: ttsState);
      });
    });

    // Listen to Voice Interaction Manager to auto-set response
    ref.listen<VoiceState>(voiceInteractionProvider, (previous, next) {
      if (next is VoiceSpeaking) {
        setResponse(next.response);
      }
    });
  }

  /// Sets the current response and starts TTS.
  Future<void> setResponse(BotResponse response) async {
    state = state.copyWith(
      response: response,
      ttsState: TtsState.speaking,
    ); // Optimistic update

    // Start TTS via Service
    // Note: VoiceInteractionManager already calls TTS!
    // So we don't need to call ttsService.speak() here?
    // VoiceInteractionManager:
    // await _ttsService.speak(responseText, _currentLanguage);

    // So we just need to update our UI state.
    // But wait, if we want to REPLAY or change speed, WE need to call TTS.

    // VoiceInteractionManager creates the initial speech.
  }

  /// Toggle Play/Pause
  Future<void> togglePlayback() async {
    final ttsService = ref.read(ttsServiceProvider);
    if (state.ttsState == TtsState.speaking) {
      await ttsService.pause();
    } else if (state.ttsState == TtsState.paused) {
      await ttsService.resume();
    } else {
      // Replay
      play();
    }
  }

  /// Stop playback
  Future<void> stop() async {
    final ttsService = ref.read(ttsServiceProvider);
    await ttsService.stop();
  }

  /// Play current response from start
  Future<void> play() async {
    if (state.response == null) return;

    final ttsService = ref.read(ttsServiceProvider);
    await ttsService.speak(
      state.response!.responseText,
      state.response!.language,
    );
  }

  /// Set playback speed
  void setSpeed(double speed) {
    state = state.copyWith(speed: speed);
    // TODO: Implement speed control in TTS Service (ElevenLabs/Sarvam might not support real-time speed change)
    // For now just update UI state.
    // If using local TTS or audio player, we can set speed.
    // TtsService interface usually has setSpeed?
    // Let's check TtsService.
    // It doesn't seem to have setSpeed in the interface I viewed earlier?
    // ElevenLabsTtsService had setDefaultSpeed?
  }
}

final responseProvider = NotifierProvider<ResponseController, ResponseState>(
  ResponseController.new,
);
