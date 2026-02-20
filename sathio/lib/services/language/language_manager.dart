import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'language_providers.dart';

/// Manages the application's active language.
/// Persists preference to Hive and handles auto-detection logic.
class LanguageManager extends Notifier<String> {
  static const String _boxName = 'settings';
  static const String _keyLanguage = 'language_code';

  @override
  String build() {
    // Load saved language or default to Hindi
    final box = Hive.box(_boxName);
    return box.get(_keyLanguage, defaultValue: 'hi') as String;
  }

  /// Explicitly set the language (e.g. from UI picker).
  Future<void> setLanguage(String langCode) async {
    if (state == langCode) return;

    state = langCode;
    final box = Hive.box(_boxName);
    await box.put(_keyLanguage, langCode);
    debugPrint('LanguageManager: Switched to $langCode');
  }

  /// Attempt to detect language from audio and switch if confidence is high.
  /// Returns the detected language code if a switch happened, null otherwise.
  Future<String?> autoDetectAndSwitch(String audioPath) async {
    final detector = ref.read(languageDetectorProvider);

    // 1. Detect language
    final result = await detector.detectLanguage(audioPath);

    if (result == null) return null;

    debugPrint(
      'LanguageManager: Detected ${result.name} (${result.code}) with ${(result.confidence * 100).toStringAsFixed(1)}% confidence',
    );

    // 2. Check confidence threshold (70%)
    if (result.confidence < 0.7) {
      debugPrint(
        'LanguageManager: Confidence too low, keeping current language.',
      );
      return null;
    }

    // 3. Switch if different from current
    if (result.code != state) {
      // Only switch if it's one of our supported languages
      // (Supported: hi, bn, ta, mr, te, kn, gu, pa, ml, or, as, ur, en)
      await setLanguage(result.code);
      return result.code;
    }

    return null;
  }

  /// Handle voice command language switching (e.g., "Tamil mein baat karo")
  Future<void> switchByVoiceCommand(String text) async {
    final lower = text.toLowerCase();

    if (lower.contains('english')) {
      await setLanguage('en');
    } else if (lower.contains('hindi') || lower.contains('हिंदी')) {
      await setLanguage('hi');
    } else if (lower.contains('tamil') || lower.contains('தமிழ்')) {
      await setLanguage('ta');
    } else if (lower.contains('marathi') || lower.contains('मराठी')) {
      await setLanguage('mr');
    } else if (lower.contains('bengali') || lower.contains('bangla')) {
      await setLanguage('bn');
    } else if (lower.contains('telugu') || lower.contains('తెలుగు')) {
      await setLanguage('te');
    } else if (lower.contains('kannada') || lower.contains('ಕನ್ನಡ')) {
      await setLanguage('kn');
    } else if (lower.contains('gujarati') || lower.contains('ગુજરાતી')) {
      await setLanguage('gu');
    } else if (lower.contains('punjabi') || lower.contains('ਪੰਜਾਬੀ')) {
      await setLanguage('pa');
    } else if (lower.contains('malayalam') || lower.contains('മലയാളം')) {
      await setLanguage('ml');
    } else if (lower.contains('odia') || lower.contains('ଓଡ଼ିଆ')) {
      await setLanguage('or');
    }
  }

  /// Get language name for UI display
  String getLanguageName(String code) {
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
}
