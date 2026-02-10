import 'package:flutter/material.dart';

class CircleRevealClipper extends CustomClipper<Path> {
  final double revealPercent;
  final Offset centerOffset;

  CircleRevealClipper({
    required this.revealPercent,
    required this.centerOffset,
  });

  @override
  Path getClip(Size size) {
    // Calculate distance from center to furthest corner for max radius
    final double maxRadius =
        (Offset.zero - centerOffset).distance >
            (Offset(size.width, size.height) - centerOffset).distance
        ? (Offset.zero - centerOffset).distance
        : (Offset(size.width, size.height) - centerOffset).distance;

    // Expand radius based on percentage
    final double radius =
        maxRadius * revealPercent * 1.5; // * 1.5 ensures full coverage

    final path = Path();
    path.addOval(Rect.fromCircle(center: centerOffset, radius: radius));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
