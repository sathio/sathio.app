import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'tts_service.dart';

/// Local TTS implementation using the flutter_tts package.
/// Works offline — used as the fallback when Bhashini/Sarvam are unavailable.
class LocalTtsService implements TtsService {
  final FlutterTts _tts = FlutterTts();
  final _stateController = StreamController<TtsState>.broadcast();
  TtsState _currentState = TtsState.idle;
  double _defaultSpeed = 1.0;

  /// Language code → flutter_tts locale mapping.
  /// Some devices use full locale strings; we try the most common ones.
  static const _languageLocales = <String, String>{
    'hi': 'hi-IN',
    'bn': 'bn-IN',
    'ta': 'ta-IN',
    'mr': 'mr-IN',
    'te': 'te-IN',
    'kn': 'kn-IN',
    'gu': 'gu-IN',
    'pa': 'pa-IN',
    'ml': 'ml-IN',
    'or': 'or-IN',
    'as': 'as-IN',
    'ur': 'ur-IN',
    'en': 'en-IN',
  };

  LocalTtsService() {
    _init();
  }

  Future<void> _init() async {
    // Configure TTS engine
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);
    await _tts.setSpeechRate(0.5); // flutter_tts uses 0.0–1.0 scale

    // Bind callbacks
    _tts.setStartHandler(() {
      _setState(TtsState.speaking);
    });

    _tts.setCompletionHandler(() {
      _setState(TtsState.idle);
    });

    _tts.setCancelHandler(() {
      _setState(TtsState.idle);
    });

    _tts.setErrorHandler((msg) {
      debugPrint('LocalTTS error: $msg');
      _setState(TtsState.error);
    });

    _tts.setPauseHandler(() {
      _setState(TtsState.paused);
    });

    _tts.setContinueHandler(() {
      _setState(TtsState.speaking);
    });
  }

  void _setState(TtsState state) {
    _currentState = state;
    _stateController.add(state);
  }

  /// Convert our speed multiplier (0.75, 1.0, 1.25) to flutter_tts rate (0.0–1.0).
  double _toFlutterSpeed(double speed) {
    // flutter_tts: 0.5 is normal on most platforms
    // Mapping: 0.75x→0.35, 1.0x→0.5, 1.25x→0.65, 1.5x→0.75
    return (speed * 0.5).clamp(0.1, 1.0);
  }

  @override
  Future<void> speak(
    String text,
    String language, {
    double speed = 0, // 0 means "use default"
    double pitch = 1.0,
  }) async {
    final effectiveSpeed = speed <= 0 ? _defaultSpeed : speed;
    try {
      // Set language
      final locale = _languageLocales[language] ?? 'en-IN';
      final result = await _tts.setLanguage(locale);
      if (result == 0) {
        debugPrint(
          'LocalTTS: Language $locale not available, falling back to en-IN',
        );
        await _tts.setLanguage('en-IN');
      }

      // Set rate and pitch
      await _tts.setSpeechRate(_toFlutterSpeed(effectiveSpeed));
      await _tts.setPitch(pitch.clamp(0.5, 2.0));

      // Speak
      final speakResult = await _tts.speak(text);
      if (speakResult != 1) {
        throw const TtsException('Failed to start speaking', provider: 'local');
      }
    } catch (e) {
      _setState(TtsState.error);
      if (e is TtsException) rethrow;
      throw TtsException(
        'Speech failed: $e',
        provider: 'local',
        originalError: e,
      );
    }
  }

  @override
  Future<void> stop() async {
    await _tts.stop();
    _setState(TtsState.idle);
  }

  @override
  Future<void> pause() async {
    await _tts.pause();
  }

  @override
  Future<void> resume() async {
    // flutter_tts doesn't have a native resume; re-speak isn't ideal
    // On platforms that support it, pause/continue handlers fire automatically
    debugPrint('LocalTTS: Resume not natively supported on all platforms');
  }

  @override
  Stream<TtsState> get stateStream => _stateController.stream;

  @override
  TtsState get currentState => _currentState;

  @override
  Future<bool> isAvailable() async {
    try {
      final engines = await _tts.getEngines;
      return engines != null && (engines as List).isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<void> setDefaultSpeed(double speed) async {
    _defaultSpeed = speed;
    await _tts.setSpeechRate(_toFlutterSpeed(speed));
  }

  /// Get the list of available languages on this device.
  Future<List<String>> getAvailableLanguages() async {
    try {
      final langs = await _tts.getLanguages;
      return (langs as List?)?.cast<String>() ?? [];
    } catch (_) {
      return [];
    }
  }

  @override
  Future<void> dispose() async {
    await _tts.stop();
    await _stateController.close();
  }
}
