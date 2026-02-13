import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// --- BuildContext Extensions ---
extension ThemeContext on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  // Media Query shortcuts
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  EdgeInsets get padding => MediaQuery.of(this).padding;
}

// --- String Extensions ---
extension StringFormatting on String {
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String get titleCase {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  // Example check for valid email
  bool get isValidEmail {
    return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(this);
  }
}

// --- DateTime Extensions ---
extension DateFormatting on DateTime {
  String get toReadableDate {
    return DateFormat('dd MMM yyyy').format(this); // e.g., 12 Oct 2023
  }

  String get toTime {
    return DateFormat('hh:mm a').format(this); // e.g., 10:30 AM
  }

  String get timeAgo {
    final difference = DateTime.now().difference(this);
    if (difference.inDays > 7) {
      return toReadableDate;
    } else if (difference.inDays >= 1) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} mins ago';
    } else {
      return 'Just now';
    }
  }
}
