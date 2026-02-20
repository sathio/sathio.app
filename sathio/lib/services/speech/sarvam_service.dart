import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'stt_service.dart';
import 'tts_service.dart';
import 'bhashini_service.dart';

/// Sarvam AI API configuration.
/// Premium Indian voice services — more natural, human-like.
class _SarvamConfig {
  static String get apiKey => dotenv.env['SARVAM_API_KEY'] ?? '';

  static const baseUrl = 'https://api.sarvam.ai';
  static const asrEndpoint = '/speech-to-text';
  static const ttsEndpoint = '/text-to-speech';
  // ignore: unused_field
  static const translateEndpoint = '/translate';

  /// Sarvam language codes.
  static const languageMap = <String, String>{
    'hi': 'hi-IN',
    'bn': 'bn-IN',
    'ta': 'ta-IN',
    'mr': 'mr-IN',
    'te': 'te-IN',
    'kn': 'kn-IN',
    'gu': 'gu-IN',
    'pa': 'pa-IN',
    'ml': 'ml-IN',
    'or': 'od-IN', // Sarvam uses 'od' for Odia
    'en': 'en-IN',
  };

  /// Sarvam TTS voice models per language.
  static const ttsVoices = <String, String>{
    'hi-IN': 'meera', // Female Hindi voice
    'bn-IN': 'meera',
    'ta-IN': 'meera',
    'mr-IN': 'meera',
    'te-IN': 'meera',
    'kn-IN': 'meera',
    'gu-IN': 'meera',
    'pa-IN': 'meera',
    'ml-IN': 'meera',
    'od-IN': 'meera',
    'en-IN': 'meera',
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// Sarvam STT
// ─────────────────────────────────────────────────────────────────────────────

/// Sarvam AI ASR — premium speech recognition with better accuracy.
/// Falls back to BhashiniSttService when Sarvam fails or has no credits.
class SarvamSttService implements SttService {
  final Dio _dio = Dio();

  SarvamSttService() {
    _dio.options.baseUrl = _SarvamConfig.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 15);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
  }

  @override
  Future<TranscriptionResult> transcribe(
    String audioPath,
    String language,
  ) async {
    final sarvamLang = _SarvamConfig.languageMap[language] ?? 'unknown';

    try {
      if (kIsWeb) {
        throw const SttException(
          'File-based transcription not supported on web',
          provider: 'sarvam',
        );
      }

      final file = File(audioPath);
      if (!await file.exists()) {
        throw SttException(
          'Audio file not found: $audioPath',
          provider: 'sarvam',
        );
      }

      debugPrint('Sarvam STT: Transcribing $audioPath in $sarvamLang...');

      // Sarvam API uses multipart form-data with file upload
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          audioPath,
          filename: audioPath.split('/').last,
        ),
        'language_code': sarvamLang,
        'model': 'saaras:v3',
        'with_timestamps': 'false',
      });

      final response = await _dio.post(
        _SarvamConfig.asrEndpoint,
        options: Options(
          headers: {'api-subscription-key': _SarvamConfig.apiKey},
        ),
        data: formData,
      );

      final data = response.data;
      debugPrint('Sarvam STT response: $data');

      final transcript = data['transcript'] as String? ?? '';
      final detectedLang = data['language_code'] as String?;
      final confidence = (data['confidence'] as num?)?.toDouble() ?? 0.85;

      if (transcript.isEmpty) {
        throw const SttException(
          'Empty transcript from Sarvam',
          provider: 'sarvam',
        );
      }

      return TranscriptionResult(
        text: transcript,
        confidence: confidence,
        language: detectedLang ?? language,
        metadata: {'provider': 'sarvam', 'language_code': sarvamLang},
      );
    } on SttException {
      rethrow;
    } catch (e) {
      debugPrint('Sarvam STT failed: $e');
      throw SttException('Sarvam STT failed: $e', provider: 'sarvam');
    }
  }

  @override
  Future<bool> isAvailable() async {
    if (_SarvamConfig.apiKey.isEmpty) return false;

    try {
      // Simple health check — verify API key works
      final response = await _dio.get(
        '/health',
        options: Options(
          headers: {'api-subscription-key': _SarvamConfig.apiKey},
        ),
      );
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<void> dispose() async {
    _dio.close();
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Sarvam TTS
// ─────────────────────────────────────────────────────────────────────────────

/// Sarvam AI TTS — premium, human-like, expressive voice synthesis.
/// Falls back to BhashiniTtsService → then LocalTtsService if unavailable.
class SarvamTtsService implements TtsService {
  final Dio _dio = Dio();
  final _stateController = StreamController<TtsState>.broadcast();
  TtsState _currentState = TtsState.idle;
  // ignore: unused_field
  double _defaultSpeed = 1.0;

  /// Fallback chain: Sarvam → Bhashini → Local
  final BhashiniTtsService _fallback = BhashiniTtsService();

  /// Callback to play audio bytes — set by the provider layer.
  Future<void> Function(String base64Audio)? onAudioReady;

  SarvamTtsService() {
    _dio.options.baseUrl = _SarvamConfig.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 15);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
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
    final sarvamLang = _SarvamConfig.languageMap[language];
    if (sarvamLang == null) {
      debugPrint('Sarvam: Language $language not supported, falling back');
      await _fallback.speak(text, language, speed: speed, pitch: pitch);
      return;
    }

    _setState(TtsState.speaking);

    try {
      final voice = _SarvamConfig.ttsVoices[sarvamLang] ?? 'meera';

      final response = await _dio.post(
        _SarvamConfig.ttsEndpoint,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'api-subscription-key': _SarvamConfig.apiKey,
          },
        ),
        data: {
          'inputs': [text],
          'target_language_code': sarvamLang,
          'speaker': voice,
          'pitch': pitch,
          'pace': speed,
          'loudness': 1.5,
          'speech_sample_rate': 22050,
          'enable_preprocessing': true,
          'model': 'bulbul:v1',
        },
      );

      final data = response.data;
      final audios = data['audios'] as List?;
      if (audios == null || audios.isEmpty) {
        throw const TtsException(
          'Empty audio response from Sarvam',
          provider: 'sarvam',
        );
      }

      final audioBase64 = audios[0] as String;

      if (onAudioReady != null) {
        await onAudioReady!(audioBase64);
      }

      _setState(TtsState.idle);
    } catch (e) {
      debugPrint('Sarvam TTS failed, falling back: $e');
      _setState(TtsState.idle);
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
    if (_SarvamConfig.apiKey.isEmpty) return false;

    try {
      final response = await _dio.get(
        '/health',
        options: Options(
          headers: {'api-subscription-key': _SarvamConfig.apiKey},
        ),
      );
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<void> setDefaultSpeed(double speed) async {
    _defaultSpeed = speed;
  }

  @override
  Future<void> dispose() async {
    _dio.close();
    await _fallback.dispose();
    await _stateController.close();
  }
}
