class AppConstants {
  static const String appName = 'Sathio';
  static const String appTagline = 'Main hoon na';

  // --- Configuration ---
  static const int maxRecordingDurationSec = 60;
  static const int apiTimeoutSec = 30;
  static const bool enableAutoDetect = true; // Uses Bhashini API

  // --- Language Support (Phased) ---

  // Phase 1 (MVP)
  static const List<String> supportedLanguagesPhase1 = [
    'hi', // Hindi
    'bn', // Bengali
    'ta', // Tamil
    'mr', // Marathi
  ];

  // Phase 2
  static const List<String> supportedLanguagesPhase2 = [
    'te', // Telugu
    'kn', // Kannada
    'gu', // Gujarati
    'pa', // Punjabi
  ];

  // Phase 3
  static const List<String> supportedLanguagesPhase3 = [
    'ml', // Malayalam
    'or', // Odia
    'as', // Assamese
    'ur', // Urdu
  ];

  // Current active languages for the app
  static const List<String> activeLanguages = [
    ...supportedLanguagesPhase1,
    // Add Phase 2, 3, etc. here as they are rolled out
  ];

  // Language Code -> Native Name Map
  static const Map<String, String> languageNames = {
    'hi': 'हिंदी',
    'bn': 'বাংলা',
    'ta': 'தமிழ்',
    'mr': 'मराठी',
    'te': 'తెలుగు',
    'kn': 'ಕನ್ನಡ',
    'gu': 'ગુજરાતી',
    'pa': 'ਪੰਜਾਬੀ',
    'ml': 'മലയാളം',
    'or': 'ଓଡ଼ିଆ',
    'as': 'অসমীয়া',
    'ur': 'اردو',
    // English fallback/default if needed
    'en': 'English',
  };
}
