import 'dart:async';

/// Abstract Text-to-Speech (TTS) service interface.
/// All TTS implementations (Bhashini, Sarvam, local flutter_tts) implement this.

/// State of the TTS engine.
enum TtsState { idle, speaking, paused, error }

/// Abstract TTS service.
/// Implementations: LocalTtsService, BhashiniTtsService, SarvamTtsService.
abstract class TtsService {
  /// Speak the given [text] in the specified [language].
  ///
  /// - [text]: String to synthesize.
  /// - [language]: BCP-47 or ISO 639-1 language code (e.g. 'hi', 'ta').
  /// - [speed]: Playback speed multiplier (default 1.0). Typical: 0.75, 1.0, 1.25.
  /// - [pitch]: Voice pitch (0.5–2.0, default 1.0). Not all providers support this.
  /// - Throws [TtsException] on failure.
  Future<void> speak(
    String text,
    String language, {
    double speed,
    double pitch,
  });

  /// Stop any ongoing speech.
  Future<void> stop();

  /// Pause speech (if supported by the provider).
  Future<void> pause();

  /// Resume paused speech (if supported by the provider).
  Future<void> resume();

  /// Stream of [TtsState] changes for UI binding.
  Stream<TtsState> get stateStream;

  /// Current TTS state.
  TtsState get currentState;

  /// Check if the service is available (engine loaded, API reachable).
  Future<bool> isAvailable();

  /// Set default speaking rate (persists for the session).
  Future<void> setDefaultSpeed(double speed);

  /// Clean up resources.
  Future<void> dispose();
}

/// Exception thrown by TTS services.
class TtsException implements Exception {
  final String message;
  final String? provider;
  final dynamic originalError;

  const TtsException(this.message, {this.provider, this.originalError});

  @override
  String toString() => 'TtsException($provider): $message';
}
