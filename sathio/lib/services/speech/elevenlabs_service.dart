import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'tts_service.dart';
import 'sarvam_service.dart';

/// ElevenLabs TTS configuration.
class _ElevenLabsConfig {
  static String get apiKey => dotenv.env['ELEVENLABS_API_KEY'] ?? '';
  static const baseUrl = 'https://api.elevenlabs.io/v1';

  // Best neutral voice ID (e.g. "Rachel" or "George" - using George for now as assistant)
  // Can be swapped for a female voice like "Rachel" -> 21m00Tcm4TlvDq8ikWAM
  // "George" -> JBFqnCBsd6RMkjVDRZzb
  static const defaultVoiceId = 'JBFqnCBsd6RMkjVDRZzb';

  // Model optimized for Indian languages (Hindi, Tamil, etc.)
  static const modelId = 'eleven_multilingual_v2';
}

/// ElevenLabs TTS — Premium, ultra-realistic voice synthesis.
/// Supports English, Hindi, Tamil, Telugu, Kannada, Marathi etc.
/// Falls back to SarvamTtsService if quota exceeded or error.
class ElevenLabsTtsService implements TtsService {
  final Dio _dio = Dio();
  final _stateController = StreamController<TtsState>.broadcast();
  TtsState _currentState = TtsState.idle;

  // Fallback to Sarvam if ElevenLabs fails
  final SarvamTtsService _fallback = SarvamTtsService();

  /// Callback to play audio bytes — set by the provider layer.
  Future<void> Function(String base64Audio)? onAudioReady;

  ElevenLabsTtsService() {
    _dio.options.baseUrl = _ElevenLabsConfig.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 15);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.headers = {
      'xi-api-key': _ElevenLabsConfig.apiKey,
      'Content-Type': 'application/json',
    };
  }

  void _setState(TtsState state) {
    _currentState = state;
    _stateController.add(state);
  }

  @override
  Future<void> speak(
    String text,
    String language, {
    double speed = 1.0,
    double pitch = 1.0,
  }) async {
    // If no API key, use fallback immediately
    if (_ElevenLabsConfig.apiKey.isEmpty) {
      debugPrint('ElevenLabs: No API key, falling back to Sarvam');
      await _fallback.speak(text, language, speed: speed, pitch: pitch);
      return;
    }

    _setState(TtsState.speaking);
    debugPrint(
      'ElevenLabs: Generating speech for "$text" (${text.length} chars)',
    );

    try {
      final response = await _dio.post(
        '/text-to-speech/${_ElevenLabsConfig.defaultVoiceId}',
        options: Options(
          responseType: ResponseType.bytes, // Get binary audio
        ),
        data: {
          'text': text,
          'model_id': _ElevenLabsConfig.modelId,
          'voice_settings': {
            'stability': 0.5,
            'similarity_boost': 0.75,
            'style': 0.0,
            'use_speaker_boost': true,
          },
        },
      );

      final audioBytes = response.data as List<int>;
      final audioBase64 = base64Encode(audioBytes);

      debugPrint('ElevenLabs: Audio generated (${audioBytes.length} bytes)');

      if (onAudioReady != null) {
        await onAudioReady!(audioBase64);
      }

      _setState(TtsState.idle);
    } catch (e) {
      debugPrint('ElevenLabs TTS failed: $e');
      debugPrint('ElevenLabs: Falling back to Sarvam...');
      _setState(TtsState.idle);
      // Fallback to Sarvam
      await _fallback.speak(text, language, speed: speed, pitch: pitch);
    }
  }

  @override
  Future<void> stop() async {
    _setState(TtsState.idle);
    await _fallback.stop();
  }

  @override
  Future<void> pause() async {
    _setState(TtsState.paused);
  }

  @override
  Future<void> resume() async {
    _setState(TtsState.speaking);
  }

  @override
  Stream<TtsState> get stateStream => _stateController.stream;

  @override
  TtsState get currentState => _currentState;

  @override
  Future<bool> isAvailable() async {
    return _ElevenLabsConfig.apiKey.isNotEmpty;
  }

  @override
  Future<void> setDefaultSpeed(double speed) async {
    // ElevenLabs controls speed via voice settings, harder to change globally
  }

  @override
  Future<void> dispose() async {
    _dio.close();
    await _fallback.dispose();
    await _stateController.close();
  }
}
