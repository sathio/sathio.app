import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'stt_service.dart';
import 'tts_service.dart';
import 'local_tts_service.dart';

/// Bhashini API configuration.
/// Uses ULCA (https://bhashini.gov.in) — free for all 22 scheduled Indian languages.
class _BhashiniConfig {
  static String get userId => dotenv.env['BHASHINI_USER_ID'] ?? '';
  static String get apiKey => dotenv.env['BHASHINI_API_KEY'] ?? '';

  /// ULCA pipeline endpoint — used to discover ASR/TTS/NMT models.
  static const pipelineUrl =
      'https://meity-auth.ulcacontrib.org/ulca/apis/v0/model/getModelsPipeline';

  /// Default compute endpoint — actual inference happens here.
  static const computeUrl =
      'https://dhruva-api.bhashini.gov.in/services/inference/pipeline';

  /// Bhashini language codes (ISO 639-1 → Bhashini source language).
  static const languageMap = <String, String>{
    'hi': 'hi',
    'bn': 'bn',
    'ta': 'ta',
    'mr': 'mr',
    'te': 'te',
    'kn': 'kn',
    'gu': 'gu',
    'pa': 'pa',
    'ml': 'ml',
    'or': 'or',
    'as': 'as',
    'ur': 'ur',
    'en': 'en',
    // Bhashini supports all 22 scheduled languages
    'sa': 'sa', // Sanskrit
    'ne': 'ne', // Nepali
    'sd': 'sd', // Sindhi
    'ks': 'ks', // Kashmiri
    'doi': 'doi', // Dogri
    'mai': 'mai', // Maithili
    'mni': 'mni', // Manipuri
    'sat': 'sat', // Santali
    'bo': 'bo', // Bodo
    'kok': 'kok', // Konkani
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// Bhashini STT
// ─────────────────────────────────────────────────────────────────────────────

/// Bhashini ASR (Automatic Speech Recognition) implementation.
/// Free, supports 22 Indian languages via the ULCA pipeline.
class BhashiniSttService implements SttService {
  final Dio _dio = Dio();

  /// Cached pipeline config (serviceId, modelId) per language.
  final Map<String, Map<String, String>> _asrModelCache = {};

  BhashiniSttService() {
    _dio.options.connectTimeout = const Duration(seconds: 15);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
  }

  /// Discover the ASR model for a given language from ULCA pipeline.
  Future<Map<String, String>> _getAsrModel(String language) async {
    if (_asrModelCache.containsKey(language)) {
      return _asrModelCache[language]!;
    }

    try {
      final response = await _dio.post(
        _BhashiniConfig.pipelineUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'ulcaApiKey': _BhashiniConfig.apiKey,
            'userID': _BhashiniConfig.userId,
          },
        ),
        data: {
          'pipelineTasks': [
            {
              'taskType': 'asr',
              'config': {
                'language': {'sourceLanguage': language},
              },
            },
          ],
          'pipelineRequestConfig': {'pipelineId': '64392f96daac500b55c543cd'},
        },
      );

      final data = response.data;
      final configs = data['pipelineResponseConfig'] as List?;
      if (configs == null || configs.isEmpty) {
        throw SttException(
          'No ASR model found for $language',
          provider: 'bhashini',
        );
      }

      final asrConfig = configs[0]['config'] as List;
      final serviceId = asrConfig[0]['serviceId'] as String;
      final modelId = asrConfig[0]['modelId'] as String? ?? '';
      final callbackUrl =
          data['pipelineInferenceAPIEndPoint']?['callbackUrl'] as String?;

      final model = {
        'serviceId': serviceId,
        'modelId': modelId,
        'callbackUrl': callbackUrl ?? _BhashiniConfig.computeUrl,
      };

      _asrModelCache[language] = model;
      return model;
    } catch (e) {
      if (e is SttException) rethrow;
      throw SttException(
        'Failed to discover ASR model: $e',
        provider: 'bhashini',
        originalError: e,
      );
    }
  }

  @override
  Future<TranscriptionResult> transcribe(
    String audioPath,
    String language,
  ) async {
    final bhashiniLang = _BhashiniConfig.languageMap[language] ?? language;

    try {
      // 1. Get ASR model config
      final model = await _getAsrModel(bhashiniLang);

      // 2. Read audio file and encode to base64
      String audioBase64;
      if (kIsWeb) {
        // On web, audioPath may already be a data URL or blob — handle differently
        throw const SttException(
          'Direct file transcription not supported on web. Use a different approach.',
          provider: 'bhashini',
        );
      } else {
        final file = File(audioPath);
        if (!await file.exists()) {
          throw SttException(
            'Audio file not found: $audioPath',
            provider: 'bhashini',
          );
        }
        final bytes = await file.readAsBytes();
        audioBase64 = base64Encode(bytes);
      }

      // 3. Call inference endpoint
      final inferenceUrl = model['callbackUrl']!;
      final response = await _dio.post(
        inferenceUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': _BhashiniConfig.apiKey,
          },
        ),
        data: {
          'pipelineTasks': [
            {
              'taskType': 'asr',
              'config': {
                'language': {'sourceLanguage': bhashiniLang},
                'serviceId': model['serviceId'],
                'audioFormat': audioPath.endsWith('.wav')
                    ? 'wav'
                    : audioPath.endsWith('.webm')
                    ? 'webm'
                    : 'flac',
                'samplingRate': 16000,
              },
            },
          ],
          'inputData': {
            'audio': [
              {'audioContent': audioBase64},
            ],
          },
        },
      );

      final data = response.data;
      final output = data['pipelineResponse']?[0]?['output']?[0] as Map?;
      if (output == null) {
        throw const SttException(
          'Empty transcription response',
          provider: 'bhashini',
        );
      }

      return TranscriptionResult(
        text: output['source'] as String? ?? '',
        confidence: 0.85, // Bhashini doesn't return confidence; use default
        language: bhashiniLang,
        metadata: {'provider': 'bhashini', 'serviceId': model['serviceId']},
      );
    } catch (e) {
      if (e is SttException) rethrow;
      throw SttException(
        'Bhashini transcription failed: $e',
        provider: 'bhashini',
        originalError: e,
      );
    }
  }

  @override
  Future<bool> isAvailable() async {
    final hasCredentials =
        _BhashiniConfig.userId.isNotEmpty && _BhashiniConfig.apiKey.isNotEmpty;
    if (!hasCredentials) return false;

    try {
      // Quick health check — try to discover a known model
      await _getAsrModel('hi');
      return true;
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
// Bhashini TTS
// ─────────────────────────────────────────────────────────────────────────────

/// Bhashini TTS (Text-to-Speech) implementation.
/// Returns audio that we play via AudioPlayerService.
class BhashiniTtsService implements TtsService {
  final Dio _dio = Dio();
  final _stateController = StreamController<TtsState>.broadcast();
  TtsState _currentState = TtsState.idle;
  double _defaultSpeed = 1.0;

  /// Fallback to local TTS when Bhashini fails.
  final LocalTtsService _localFallback = LocalTtsService();

  /// Cached TTS model configs.
  final Map<String, Map<String, String>> _ttsModelCache = {};

  /// Callback to play audio bytes — set by the provider layer.
  Future<void> Function(String base64Audio)? onAudioReady;

  BhashiniTtsService() {
    _dio.options.connectTimeout = const Duration(seconds: 15);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
  }

  void _setState(TtsState state) {
    _currentState = state;
    _stateController.add(state);
  }

  Future<Map<String, String>> _getTtsModel(String language) async {
    if (_ttsModelCache.containsKey(language)) {
      return _ttsModelCache[language]!;
    }

    try {
      final response = await _dio.post(
        _BhashiniConfig.pipelineUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'ulcaApiKey': _BhashiniConfig.apiKey,
            'userID': _BhashiniConfig.userId,
          },
        ),
        data: {
          'pipelineTasks': [
            {
              'taskType': 'tts',
              'config': {
                'language': {'sourceLanguage': language},
              },
            },
          ],
          'pipelineRequestConfig': {'pipelineId': '64392f96daac500b55c543cd'},
        },
      );

      final data = response.data;
      final configs = data['pipelineResponseConfig'] as List?;
      if (configs == null || configs.isEmpty) {
        throw TtsException(
          'No TTS model found for $language',
          provider: 'bhashini',
        );
      }

      final ttsConfig = configs[0]['config'] as List;
      final serviceId = ttsConfig[0]['serviceId'] as String;
      final callbackUrl =
          data['pipelineInferenceAPIEndPoint']?['callbackUrl'] as String?;

      final model = {
        'serviceId': serviceId,
        'callbackUrl': callbackUrl ?? _BhashiniConfig.computeUrl,
      };

      _ttsModelCache[language] = model;
      return model;
    } catch (e) {
      if (e is TtsException) rethrow;
      throw TtsException(
        'Failed to discover TTS model: $e',
        provider: 'bhashini',
        originalError: e,
      );
    }
  }

  @override
  Future<void> speak(
    String text,
    String language, {
    double speed = 0,
    double pitch = 1.0,
  }) async {
    final effectiveSpeed = speed <= 0 ? _defaultSpeed : speed;
    final bhashiniLang = _BhashiniConfig.languageMap[language] ?? language;
    _setState(TtsState.speaking);

    try {
      final model = await _getTtsModel(bhashiniLang);

      final response = await _dio.post(
        model['callbackUrl']!,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': _BhashiniConfig.apiKey,
          },
        ),
        data: {
          'pipelineTasks': [
            {
              'taskType': 'tts',
              'config': {
                'language': {'sourceLanguage': bhashiniLang},
                'serviceId': model['serviceId'],
                'gender': 'female',
              },
            },
          ],
          'inputData': {
            'input': [
              {'source': text},
            ],
          },
        },
      );

      final data = response.data;
      final audioContent =
          data['pipelineResponse']?[0]?['audio']?[0]?['audioContent']
              as String?;

      if (audioContent == null || audioContent.isEmpty) {
        throw const TtsException(
          'Empty audio response from Bhashini',
          provider: 'bhashini',
        );
      }

      // Delegate audio playback to the registered callback
      if (onAudioReady != null) {
        await onAudioReady!(audioContent);
      }

      _setState(TtsState.idle);
    } catch (e) {
      debugPrint('Bhashini TTS failed, falling back to local TTS: $e');
      _setState(TtsState.idle);
      // Fallback to local TTS
      await _localFallback.speak(
        text,
        language,
        speed: effectiveSpeed,
        pitch: pitch,
      );
    }
  }

  @override
  Future<void> stop() async {
    _setState(TtsState.idle);
    await _localFallback.stop();
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
    final hasCredentials =
        _BhashiniConfig.userId.isNotEmpty && _BhashiniConfig.apiKey.isNotEmpty;
    if (!hasCredentials) return false;

    try {
      await _getTtsModel('hi');
      return true;
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
    await _localFallback.dispose();
    await _stateController.close();
  }
}
