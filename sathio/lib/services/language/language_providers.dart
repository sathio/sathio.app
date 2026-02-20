import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'language_detector_service.dart';
import 'language_manager.dart';

/// Provider for the [LanguageDetectorService].
final languageDetectorProvider = Provider<LanguageDetectorService>((ref) {
  return LanguageDetectorService();
});

/// Provider for the [LanguageManager].
/// Exposes the current language code as state.
final languageManagerProvider = NotifierProvider<LanguageManager, String>(
  LanguageManager.new,
);

/// Convenience provider for current language code.
final currentLanguageProvider = Provider<String>((ref) {
  return ref.watch(languageManagerProvider);
});
