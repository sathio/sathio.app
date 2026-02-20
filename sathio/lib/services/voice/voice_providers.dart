import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'voice_state.dart';
import 'voice_interaction_manager.dart';

/// Main voice interaction manager provider.
/// Orchestrates: mic tap → record → STT → intent → response → TTS.
final voiceInteractionProvider =
    NotifierProvider<VoiceInteractionManager, VoiceState>(
      VoiceInteractionManager.new,
    );

/// Convenience provider: is the voice system currently listening?
final isListeningProvider = Provider<bool>((ref) {
  final voiceState = ref.watch(voiceInteractionProvider);
  return voiceState is VoiceListening;
});

/// Convenience provider: is the voice system currently processing?
final isProcessingProvider = Provider<bool>((ref) {
  final voiceState = ref.watch(voiceInteractionProvider);
  return voiceState is VoiceProcessing;
});

/// Convenience provider: is the voice system currently speaking?
final isSpeakingProvider = Provider<bool>((ref) {
  final voiceState = ref.watch(voiceInteractionProvider);
  return voiceState is VoiceSpeaking;
});

/// Convenience provider: current error message (null if no error).
final voiceErrorProvider = Provider<String?>((ref) {
  final voiceState = ref.watch(voiceInteractionProvider);
  if (voiceState is VoiceError) {
    return voiceState.message;
  }
  return null;
});
