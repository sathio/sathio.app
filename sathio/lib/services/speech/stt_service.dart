/// Abstract Speech-to-Text (STT) service interface.
/// All STT implementations (Bhashini, Sarvam, local) implement this.
library;

/// Result of a speech transcription.
class TranscriptionResult {
  /// Transcribed text.
  final String text;

  /// Confidence score (0.0 – 1.0).
  final double confidence;

  /// Detected or specified language code (e.g. 'hi', 'bn', 'ta').
  final String language;

  /// Raw response metadata (provider-specific).
  final Map<String, dynamic>? metadata;

  const TranscriptionResult({
    required this.text,
    required this.confidence,
    required this.language,
    this.metadata,
  });

  bool get isEmpty => text.trim().isEmpty;
  bool get isHighConfidence => confidence >= 0.7;

  @override
  String toString() =>
      'TranscriptionResult(text: "$text", confidence: $confidence, lang: $language)';
}

/// Abstract STT service.
/// Implementations: BhashiniSttService, SarvamSttService, (future: local).
abstract class SttService {
  /// Transcribe an audio file at [audioPath] in the given [language].
  ///
  /// - [audioPath]: local file path to the recorded audio (m4a, wav, webm).
  /// - [language]: BCP-47 or ISO 639-1 language code (e.g. 'hi', 'en').
  /// - Returns [TranscriptionResult] with transcribed text and confidence.
  /// - Throws [SttException] on failure.
  Future<TranscriptionResult> transcribe(String audioPath, String language);

  /// Check if the service is available (API reachable, credentials valid).
  Future<bool> isAvailable();

  /// Clean up any resources.
  Future<void> dispose();
}

/// Exception thrown by STT services.
class SttException implements Exception {
  final String message;
  final String? provider;
  final dynamic originalError;

  const SttException(this.message, {this.provider, this.originalError});

  @override
  String toString() => 'SttException($provider): $message';
}
