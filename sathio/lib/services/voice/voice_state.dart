/// Voice interaction state machine.
/// Each state carries relevant data for UI binding.
library;

/// Response from the bot (transcription result + AI response).
class BotResponse {
  final String transcribedText;
  final String responseText;
  final String language;
  final DateTime timestamp;

  final String? contextTitle;
  final List<String>? steps;
  final bool isActionable;

  const BotResponse({
    required this.transcribedText,
    required this.responseText,
    required this.language,
    required this.timestamp,
    this.contextTitle,
    this.steps,
    this.isActionable = false,
  });

  @override
  String toString() =>
      'BotResponse(query: "$transcribedText", response: "$responseText", steps: ${steps?.length})';
}

/// Sealed class for voice interaction states.
/// Dart 3 sealed classes give exhaustive switch matching.
sealed class VoiceState {
  const VoiceState();
}

/// Ready to listen — mic button shows idle pulse.
class VoiceIdle extends VoiceState {
  const VoiceIdle();
}

/// Recording audio — mic button shows waveform.
class VoiceListening extends VoiceState {
  /// Recording duration so far.
  final Duration elapsed;

  /// Current amplitude (0.0–1.0) for waveform visualization.
  final double amplitude;

  const VoiceListening({this.elapsed = Duration.zero, this.amplitude = 0.0});

  VoiceListening copyWith({Duration? elapsed, double? amplitude}) =>
      VoiceListening(
        elapsed: elapsed ?? this.elapsed,
        amplitude: amplitude ?? this.amplitude,
      );
}

/// Processing the recorded audio — transcribing, classifying intent.
class VoiceProcessing extends VoiceState {
  /// Current substep for UI feedback.
  final ProcessingStep step;

  /// Partial transcription text (if streaming STT is supported).
  final String? partialText;

  const VoiceProcessing({
    this.step = ProcessingStep.transcribing,
    this.partialText,
  });
}

/// Sub-steps within processing.
enum ProcessingStep {
  detectingLanguage,
  transcribing,
  classifyingIntent,
  generatingResponse,
}

/// Speaking the TTS response — shows response card + plays audio.
class VoiceSpeaking extends VoiceState {
  final BotResponse response;

  /// Progress of TTS playback (0.0–1.0).
  final double progress;

  const VoiceSpeaking({required this.response, this.progress = 0.0});

  VoiceSpeaking copyWith({double? progress}) =>
      VoiceSpeaking(response: response, progress: progress ?? this.progress);
}

/// Executing an agentic action (LAM) — shows action card.
class VoiceExecutingAction extends VoiceState {
  final String actionDescription;
  final double progress;

  const VoiceExecutingAction({
    required this.actionDescription,
    this.progress = 0.0,
  });
}

/// Waiting for user input during slot filling.
/// Example: "Aapka phone number bataiye" during form filling.
class VoiceWaitingForInput extends VoiceState {
  final String prompt;
  final String fieldName;

  const VoiceWaitingForInput({required this.prompt, required this.fieldName});
}

/// Error state — shows error UI with retry option.
class VoiceError extends VoiceState {
  final String message;
  final String? errorCode;

  /// Whether the error is recoverable (show retry button).
  final bool canRetry;

  const VoiceError({
    required this.message,
    this.errorCode,
    this.canRetry = true,
  });
}
