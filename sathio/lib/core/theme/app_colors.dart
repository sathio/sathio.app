import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors
  static const Color teal = Color(0xFF00BFA5); // Sathio Teal
  static const Color orange = Color(0xFFFF9800); // Saffron Orange
  static const Color blue = Color(0xFF1E3A5F); // Deep Blue

  // Semantic Colors
  static const Color primary = orange; // Changed from teal
  static const Color secondary = teal; // Changed from orange
  static const Color tertiary = blue;

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF2196F3);

  // Grayscale
  static const Color gray50 = Color(0xFFFAFAFA);
  static const Color gray100 = Color(0xFFF5F5F5);
  static const Color gray200 = Color(0xFFEEEEEE);
  static const Color gray300 = Color(0xFFE0E0E0);
  static const Color gray400 = Color(0xFFBDBDBD);
  static const Color gray500 = Color(0xFF9E9E9E);
  static const Color gray600 = Color(0xFF757575);
  static const Color gray700 = Color(0xFF616161);
  static const Color gray800 = Color(0xFF424242);
  static const Color gray900 = Color(0xFF212121);

  // Backgrounds
  static const Color backgroundLight = gray100;
  static const Color surfaceLight = Colors.white;
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);

  // Text
  static const Color textPrimaryLight = gray900;
  static const Color textSecondaryLight = gray600;
  static const Color textPrimaryDark = gray200;
  static const Color textSecondaryDark = gray400;

  // Overlay
  static const Color overlay = Color(0x80000000);
}
