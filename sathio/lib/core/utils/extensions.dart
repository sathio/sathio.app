import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/app_colors.dart';

extension ThemeContext on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;

  // Quick access to colors
  Color get primaryColor => AppColors.primary;
  Color get surfaceColor => colorScheme.surface;

  // Device size
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
}

extension StringExtension on String {
  String get capitalize {
    if (isEmpty) return this;
    return '\${this[0].toUpperCase()}\${substring(1)}';
  }

  // Basic validation check
  bool get isValidEmail {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(this);
  }
}

extension DateTimeExtension on DateTime {
  String get formattedDate {
    return DateFormat('dd MMM yyyy').format(this);
  }

  String get formattedTime {
    return DateFormat('hh:mm a').format(this);
  }
}
