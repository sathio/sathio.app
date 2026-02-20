import 'package:flutter/material.dart';

/// Helper class for checking and respecting reduced-motion preferences.
/// UI_UX.md Section 8 — all animations must respect this.
class ReducedMotion {
  /// Returns true if the user has enabled reduced motion in system settings.
  static bool isReduced(BuildContext context) {
    return MediaQuery.of(context).disableAnimations;
  }

  /// Returns the given duration, or Duration.zero if reduced motion is on.
  static Duration duration(BuildContext context, Duration normal) {
    return isReduced(context) ? Duration.zero : normal;
  }
}

/// Widget that conditionally applies animations.
/// When reduced motion is ON, it shows the child with just a simple fade (or instantly).
class AnimateIf extends StatelessWidget {
  final Widget child;
  final Widget Function(Widget child) animationBuilder;
  final bool useReducedMotion;

  const AnimateIf({
    super.key,
    required this.child,
    required this.animationBuilder,
    this.useReducedMotion = true,
  });

  @override
  Widget build(BuildContext context) {
    if (useReducedMotion && ReducedMotion.isReduced(context)) {
      return child;
    }
    return animationBuilder(child);
  }
}
