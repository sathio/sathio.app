import 'package:flutter/material.dart';

class RoundedCardClipper extends CustomClipper<Path> {
  final double revealPercent;
  final double startY; // Percentage of screen height to start from (e.g., 0.8)

  RoundedCardClipper({required this.revealPercent, this.startY = 1.0});

  @override
  Path getClip(Size size) {
    final path = Path();

    // Calculate current top position
    // If revealPercent is 0, top is at size.height
    // If revealPercent is 1, top is at 0
    double currentTop = size.height * (1 - revealPercent);

    // Add rounded rectangle
    path.addRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0, currentTop, size.width, size.height),
        topLeft: const Radius.circular(32),
        topRight: const Radius.circular(32),
      ),
    );

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
