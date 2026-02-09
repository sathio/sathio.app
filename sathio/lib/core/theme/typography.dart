import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTypography {
  static const String fontFamily = 'NotoSans';

  // Font Weights
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  static TextTheme get lightTextTheme => TextTheme(
    displayLarge: _textStyle(57, regular, AppColors.textPrimaryLight),
    displayMedium: _textStyle(45, regular, AppColors.textPrimaryLight),
    displaySmall: _textStyle(36, regular, AppColors.textPrimaryLight),
    headlineLarge: _textStyle(32, regular, AppColors.textPrimaryLight),
    headlineMedium: _textStyle(28, regular, AppColors.textPrimaryLight),
    headlineSmall: _textStyle(24, regular, AppColors.textPrimaryLight),
    titleLarge: _textStyle(22, regular, AppColors.textPrimaryLight),
    titleMedium: _textStyle(16, medium, AppColors.textPrimaryLight),
    titleSmall: _textStyle(14, medium, AppColors.textPrimaryLight),
    bodyLarge: _textStyle(16, regular, AppColors.textPrimaryLight),
    bodyMedium: _textStyle(14, regular, AppColors.textPrimaryLight),
    bodySmall: _textStyle(12, regular, AppColors.textSecondaryLight),
    labelLarge: _textStyle(14, medium, AppColors.textPrimaryLight),
    labelMedium: _textStyle(12, medium, AppColors.textSecondaryLight),
    labelSmall: _textStyle(11, medium, AppColors.textSecondaryLight),
  );

  static TextTheme get darkTextTheme => TextTheme(
    displayLarge: _textStyle(57, regular, AppColors.textPrimaryDark),
    displayMedium: _textStyle(45, regular, AppColors.textPrimaryDark),
    displaySmall: _textStyle(36, regular, AppColors.textPrimaryDark),
    headlineLarge: _textStyle(32, regular, AppColors.textPrimaryDark),
    headlineMedium: _textStyle(28, regular, AppColors.textPrimaryDark),
    headlineSmall: _textStyle(24, regular, AppColors.textPrimaryDark),
    titleLarge: _textStyle(22, regular, AppColors.textPrimaryDark),
    titleMedium: _textStyle(16, medium, AppColors.textPrimaryDark),
    titleSmall: _textStyle(14, medium, AppColors.textPrimaryDark),
    bodyLarge: _textStyle(16, regular, AppColors.textPrimaryDark),
    bodyMedium: _textStyle(14, regular, AppColors.textPrimaryDark),
    bodySmall: _textStyle(12, regular, AppColors.textSecondaryDark),
    labelLarge: _textStyle(14, medium, AppColors.textPrimaryDark),
    labelMedium: _textStyle(12, medium, AppColors.textSecondaryDark),
    labelSmall: _textStyle(11, medium, AppColors.textSecondaryDark),
  );

  static TextStyle _textStyle(double size, FontWeight weight, Color color) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: size,
      fontWeight: weight,
      color: color,
    );
  }
}
