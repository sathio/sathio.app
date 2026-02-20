import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

/// Recording state machine.
enum RecordingState { idle, recording, stopped }

/// Audio recording service using the `record` package.
/// Handles permissions, temp file management, and auto-stop at max duration.
class AudioRecorderService {
  final AudioRecorder _recorder = AudioRecorder();
  String? _filePath;
  Timer? _maxDurationTimer;

  static const maxDurationSeconds = 60;

  // --- State stream ---
  final _stateController = StreamController<RecordingState>.broadcast();
  Stream<RecordingState> get stateStream => _stateController.stream;
  RecordingState _state = RecordingState.idle;
  RecordingState get state => _state;

  // --- Amplitude stream (for waveform visualization) ---
  Stream<Amplitude> get amplitudeStream =>
      _recorder.onAmplitudeChanged(const Duration(milliseconds: 100));

  bool get isRecording => _state == RecordingState.recording;

  void _setState(RecordingState newState) {
    _state = newState;
    _stateController.add(newState);
  }

  /// Request microphone permission. Returns true if granted.
  Future<bool> _ensurePermission() async {
    // On web, record package handles permission itself
    if (kIsWeb) {
      return await _recorder.hasPermission();
    }

    final status = await Permission.microphone.request();
    if (status.isGranted) return true;
    if (status.isPermanentlyDenied) {
      openAppSettings();
    }
    return false;
  }

  /// Start recording audio to a temp file.
  Future<void> startRecording() async {
    if (_state == RecordingState.recording) return;

    final hasPermission = await _ensurePermission();
    if (!hasPermission) {
      debugPrint('AudioRecorder: Microphone permission denied');
      return;
    }

    try {
      // Generate temp file path
      if (kIsWeb) {
        _filePath = 'audio_recording.webm';
      } else {
        final tempDir = await getTemporaryDirectory();
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        _filePath = '${tempDir.path}/sathio_recording_$timestamp.m4a';
      }

      await _recorder.start(
        const RecordConfig(
          encoder: kIsWeb ? AudioEncoder.opus : AudioEncoder.aacLc,
          bitRate: 128000,
          sampleRate: 44100,
          numChannels: 1,
        ),
        path: _filePath!,
      );

      _setState(RecordingState.recording);

      // Auto-stop after max duration
      _maxDurationTimer?.cancel();
      _maxDurationTimer = Timer(
        const Duration(seconds: maxDurationSeconds),
        () async {
          debugPrint('AudioRecorder: Max duration reached, auto-stopping');
          await stopRecording();
        },
      );
    } catch (e) {
      debugPrint('AudioRecorder: Failed to start recording: $e');
      _setState(RecordingState.idle);
    }
  }

  /// Stop recording and return the audio file path.
  Future<String?> stopRecording() async {
    if (_state != RecordingState.recording) return _filePath;

    _maxDurationTimer?.cancel();
    _maxDurationTimer = null;

    try {
      final path = await _recorder.stop();
      _filePath = path;
      _setState(RecordingState.stopped);
      return _filePath;
    } catch (e) {
      debugPrint('AudioRecorder: Failed to stop recording: $e');
      _setState(RecordingState.idle);
      return null;
    }
  }

  /// Cancel recording and delete the temp file.
  Future<void> cancelRecording() async {
    _maxDurationTimer?.cancel();
    _maxDurationTimer = null;

    if (_state == RecordingState.recording) {
      await _recorder.stop();
    }

    // Delete temp file
    if (_filePath != null && !kIsWeb) {
      try {
        final file = File(_filePath!);
        if (await file.exists()) {
          await file.delete();
          debugPrint('AudioRecorder: Deleted temp file $_filePath');
        }
      } catch (e) {
        debugPrint('AudioRecorder: Failed to delete temp file: $e');
      }
    }

    _filePath = null;
    _setState(RecordingState.idle);
  }

  /// Clean up resources.
  Future<void> dispose() async {
    _maxDurationTimer?.cancel();
    await _recorder.dispose();
    await _stateController.close();
  }
}
