import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'audio_recorder_service.dart';
import 'audio_player_service.dart';

/// Provider for [AudioRecorderService].
/// Singleton instance — matches VoiceInteractionManager's lifecycle.
final audioRecorderProvider = Provider<AudioRecorderService>((ref) {
  final service = AudioRecorderService();
  ref.onDispose(() => service.dispose());
  return service;
});

/// Provider for [AudioPlayerService].
/// Singleton instance — matches VoiceInteractionManager's lifecycle.
final audioPlayerProvider = Provider<AudioPlayerService>((ref) {
  final service = AudioPlayerService();
  ref.onDispose(() => service.dispose());
  return service;
});

/// Stream provider for recording state.
final recordingStateProvider = StreamProvider<RecordingState>((ref) {
  final recorder = ref.watch(audioRecorderProvider);
  return recorder.stateStream;
});

/// Stream provider for playback state.
final playbackStateProvider = StreamProvider<AudioPlaybackState>((ref) {
  final player = ref.watch(audioPlayerProvider);
  return player.playbackStateStream;
});

/// Stream provider for playback position.
final playbackPositionProvider = StreamProvider<Duration>((ref) {
  final player = ref.watch(audioPlayerProvider);
  return player.positionStream;
});

/// Stream provider for audio duration.
/// Stream provider for audio duration.
final audioDurationProvider = StreamProvider<Duration?>((ref) {
  final player = ref.watch(audioPlayerProvider);
  return player.durationStream;
});
