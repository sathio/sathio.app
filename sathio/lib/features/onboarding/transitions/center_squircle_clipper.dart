import 'package:flutter/material.dart';

class CenterSquircleClipper extends CustomClipper<Path> {
  final double revealPercent;

  CenterSquircleClipper({required this.revealPercent});

  @override
  Path getClip(Size size) {
    final path = Path();

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Max dimension to cover screen
    final maxDim = size.height > size.width ? size.height : size.width;

    // Current size
    final currentSize = maxDim * revealPercent * 1.5;

    // Draw centered RRect
    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(centerX, centerY),
          width: currentSize,
          height: currentSize,
        ),
        Radius.circular(
          currentSize * 0.2,
        ), // Dynamic radius for squircle-ish look
      ),
    );

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
