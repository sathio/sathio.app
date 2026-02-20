import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:just_audio/just_audio.dart';

/// Player state for UI consumption.
enum AudioPlaybackState { idle, playing, paused, completed }

/// Audio player service using the `just_audio` package.
/// Supports both local files and remote URLs.
class AudioPlayerService {
  final AudioPlayer _player = AudioPlayer();

  // --- Streams ---
  /// Emits playback state changes.
  Stream<AudioPlaybackState> get playbackStateStream =>
      _player.playerStateStream.map((state) {
        if (state.processingState == ProcessingState.completed) {
          return AudioPlaybackState.completed;
        }
        if (state.playing) return AudioPlaybackState.playing;
        return state.processingState == ProcessingState.idle
            ? AudioPlaybackState.idle
            : AudioPlaybackState.paused;
      });

  /// Emits current playback position.
  Stream<Duration> get positionStream => _player.positionStream;

  /// Emits total audio duration (null until loaded).
  Stream<Duration?> get durationStream => _player.durationStream;

  /// Current position (synchronous).
  Duration get position => _player.position;

  /// Total duration (synchronous).
  Duration? get duration => _player.duration;

  /// Whether currently playing.
  bool get isPlaying => _player.playing;

  /// Play audio from a URL or local file path.
  Future<void> play(String source) async {
    try {
      // Set the source
      if (source.startsWith('http://') || source.startsWith('https://')) {
        await _player.setUrl(source);
      } else {
        await _player.setFilePath(source);
      }

      await _player.play();
    } catch (e) {
      debugPrint('AudioPlayer: Failed to play: $e');
    }
  }

  /// Play audio from base64 string (used by API TTS services).
  /// Decodes, saves to temp file, and plays.
  Future<void> playFromBase64(String base64String) async {
    try {
      final bytes = base64Decode(base64String);
      final dir = await getTemporaryDirectory();
      // Use timestamp to avoid caching/overwriting issues
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final file = File('${dir.path}/tts_audio_$timestamp.mp3');

      await file.writeAsBytes(bytes);
      // Clean up previous temp files? Maybe later. For now, simple write & play.
      debugPrint('AudioPlayer: Playing generated TTS file: ${file.path}');

      await play(file.path);
    } catch (e) {
      debugPrint('AudioPlayer: Failed to play base64 audio: $e');
    }
  }

  /// Resume playback if paused.
  Future<void> resume() async {
    try {
      await _player.play();
    } catch (e) {
      debugPrint('AudioPlayer: Failed to resume: $e');
    }
  }

  /// Pause playback.
  Future<void> pause() async {
    try {
      await _player.pause();
    } catch (e) {
      debugPrint('AudioPlayer: Failed to pause: $e');
    }
  }

  /// Stop playback and reset position.
  Future<void> stop() async {
    try {
      await _player.stop();
      await _player.seek(Duration.zero);
    } catch (e) {
      debugPrint('AudioPlayer: Failed to stop: $e');
    }
  }

  /// Set playback speed. Supported values: 0.75, 1.0, 1.25, 1.5, 2.0.
  Future<void> setSpeed(double speed) async {
    try {
      await _player.setSpeed(speed);
    } catch (e) {
      debugPrint('AudioPlayer: Failed to set speed: $e');
    }
  }

  /// Seek to a specific position.
  Future<void> seek(Duration position) async {
    try {
      await _player.seek(position);
    } catch (e) {
      debugPrint('AudioPlayer: Failed to seek: $e');
    }
  }

  /// Clean up resources.
  Future<void> dispose() async {
    await _player.dispose();
  }
}
