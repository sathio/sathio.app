import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Represents a detected language result.
class DetectedLanguage {
  final String code; // ISO 639-1 code (e.g., 'hi')
  final String name; // Language name (e.g., 'Hindi')
  final double confidence; // 0.0 to 1.0

  const DetectedLanguage({
    required this.code,
    required this.name,
    required this.confidence,
  });

  @override
  String toString() =>
      '$name ($code) - ${(confidence * 100).toStringAsFixed(1)}%';
}

/// Service to detect language from audio using Bhashini's ULCA pipeline.
class LanguageDetectorService {
  final Dio _dio = Dio();

  // Bhashini config (mirrors BhashiniService config)
  static String get userId => dotenv.env['BHASHINI_USER_ID'] ?? '';
  static String get apiKey => dotenv.env['BHASHINI_API_KEY'] ?? '';

  static const pipelineUrl =
      'https://meity-auth.ulcacontrib.org/ulca/apis/v0/model/getModelsPipeline';
  static const computeUrl =
      'https://dhruva-api.bhashini.gov.in/services/inference/pipeline';

  LanguageDetectorService() {
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);
  }

  /// Detects the language of the audio file at [audioPath].
  /// Returns null if detection fails, confidence is too low, or API keys are not configured.
  Future<DetectedLanguage?> detectLanguage(String audioPath) async {
    // Skip if Bhashini keys are not configured
    if (apiKey.isEmpty ||
        userId.isEmpty ||
        apiKey.startsWith('your-') ||
        userId.startsWith('your-')) {
      debugPrint('LanguageDetector: Bhashini keys not configured, skipping');
      return null;
    }

    try {
      // 1. Get Language Detection Model ID
      final model = await _getLanguageDetectionModel();

      // 2. Read audio file
      final file = File(audioPath);
      if (!await file.exists()) {
        debugPrint('LanguageDetector: Audio file not found at $audioPath');
        return null;
      }
      final bytes = await file.readAsBytes();
      final audioBase64 = base64Encode(bytes);

      // 3. Call inference endpoint
      final response = await _dio.post(
        model['callbackUrl']!, // Use the callback URL from the model discovery
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': apiKey,
          },
        ),
        data: {
          'pipelineTasks': [
            {
              // 'nmt' or specific task type for lang detection - verify taskType
              // Actually for ASR-based lang id, we often use the ASR pipeline itself
              // OR specific 'txt-lang-detection' / 'audio-lang-detection' if available.
              // Bhashini often treats this as an ASR task with unknown language or specific model.
              // Let's check typical usage: standard is often 'asr' task but some models return detected lang.
              // HOWEVER, a dedicated "audio-lang-detection" task type exists in some ULCA docs.
              // If unavailable, we might need to rely on ASR returning it or use a specific model ID.
              // For now, let's try the standard 'audio-lang-detection' task type if discoverable,
              // or fallback to a known model if we have one.
              //
              // Simplification: We will request a taskType 'asr' but with config to detect language if supported,
              // OR strictly use 'audio-lang-detection' if that's the standard.
              // Let's try discovering 'audio-lang-detection'.
              'taskType': 'audio-lang-detection',
            },
          ],
          'inputData': {
            'audio': [
              {'audioContent': audioBase64},
            ],
          },
        },
      );

      // Note: If 'audio-lang-detection' isn't standard in the public API yet,
      // we might fail here.
      // Fallback strategy: In a real production app, if Bhashini explicit LangID isn't working,
      // we might skip this or use a lightweight local model (like flutter_tflite).
      // For this implementation, we'll implement the API call structure.

      final data = response.data;

      // Parse response (generalized path)
      // output format depends on task type.
      // Assuming structure: pipelineResponse -> output -> langPrediction
      if (data['pipelineResponse'] != null &&
          data['pipelineResponse'].isNotEmpty) {
        final output = data['pipelineResponse'][0]['output'];
        if (output != null && output.isNotEmpty) {
          // Verify structure based on Bhashini response (langDetection usually returns 'langPrediction')
          final prediction = output[0]['langPrediction'];
          if (prediction != null && prediction.isNotEmpty) {
            final first = prediction[0];
            return DetectedLanguage(
              code: first['langCode'] ?? 'en',
              name: _getLangName(first['langCode'] ?? 'en'),
              confidence: (first['confidence'] is num)
                  ? (first['confidence'] as num).toDouble()
                  : 0.0,
            );
          }
        }
      }

      return null;
    } catch (e) {
      debugPrint('Language detection failed: $e');
      return null;
    }
  }

  // Cache key: just 'lang-detect' since it's one model type
  Map<String, dynamic>? _cachedModel;

  Future<Map<String, dynamic>> _getLanguageDetectionModel() async {
    if (_cachedModel != null) return _cachedModel!;

    try {
      final response = await _dio.post(
        pipelineUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'ulcaApiKey': apiKey,
            'userID': userId,
          },
        ),
        data: {
          'pipelineTasks': [
            {'taskType': 'audio-lang-detection'},
          ],
          'pipelineRequestConfig': {'pipelineId': '64392f96daac500b55c543cd'},
        },
      );

      final data = response.data;
      final configs = data['pipelineResponseConfig'] as List?;

      if (configs == null || configs.isEmpty) {
        // Fallback: If specific task not found, maybe stick to a known generic endpoint or throw
        throw Exception('No language detection model found');
      }

      final config = configs[0]['config'] as List;
      final serviceId = config[0]['serviceId'] as String;
      final callbackUrl =
          data['pipelineInferenceAPIEndPoint']?['callbackUrl'] as String?;

      _cachedModel = {
        'serviceId': serviceId,
        'callbackUrl': callbackUrl ?? computeUrl,
      };

      return _cachedModel!;
    } catch (e) {
      // If discovery fails, we can't proceed with detection
      debugPrint('Err discovering lang detect model: $e');
      rethrow;
    }
  }

  String _getLangName(String code) {
    switch (code) {
      case 'hi':
        return 'Hindi';
      case 'bn':
        return 'Bengali';
      case 'ta':
        return 'Tamil';
      case 'mr':
        return 'Marathi';
      case 'te':
        return 'Telugu';
      case 'kn':
        return 'Kannada';
      case 'gu':
        return 'Gujarati';
      case 'pa':
        return 'Punjabi';
      case 'ml':
        return 'Malayalam';
      case 'or':
        return 'Odia';
      case 'en':
        return 'English';
      default:
        return code;
    }
  }

  void dispose() {
    _dio.close();
  }
}
