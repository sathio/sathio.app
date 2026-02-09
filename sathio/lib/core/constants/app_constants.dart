import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'Sathio';
  static const String tagline = 'Main hoon na'; // "I'm here for you"

  // Locale Support
  static const List<Locale> supportedLocales = [
    Locale('hi', 'IN'), // Hindi
    Locale('bn', 'IN'), // Bengali
    Locale('ta', 'IN'), // Tamil
    Locale('mr', 'IN'), // Marathi
    Locale('en', 'IN'), // English (fallback)
  ];

  static const String defaultLanguageCode = 'hi';

  static const Map<String, String> languageNames = {
    'hi': 'हिंदी',
    'bn': 'বাংলা',
    'ta': 'தமிழ்',
    'mr': 'मराठी',
    'en': 'English',
  };

  // API Endpoints (Placeholder)
  static const String baseUrl = 'https://api.sathio.com/v1';

  // Timeouts & Durations
  static const int connectTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
  static const int maxRecordingDuration = 120; // 120 seconds
}
