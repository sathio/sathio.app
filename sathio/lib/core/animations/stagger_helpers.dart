import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Stagger animation helpers per UI_UX.md Section 8.2 and 8.3.
///
/// Usage:
/// ```dart
/// Column(children: myWidgets.staggerIn(interval: 100.ms))
/// ```

extension StaggerAnimations on List<Widget> {
  /// Applies a staggered fadeIn + slideY to each widget in the list.
  /// Each child: fadeIn(300ms) + slideY(begin: 0.15, end: 0, duration: 400ms)
  List<Widget> staggerIn({
    Duration interval = const Duration(milliseconds: 100),
    Duration fadeInDuration = const Duration(milliseconds: 300),
    Duration slideDuration = const Duration(milliseconds: 400),
    double slideBegin = 0.15,
    Curve curve = Curves.easeOutCubic,
  }) {
    return asMap().entries.map((entry) {
      final index = entry.key;
      final widget = entry.value;
      return widget
          .animate(
            delay: Duration(milliseconds: interval.inMilliseconds * index),
          )
          .fadeIn(duration: fadeInDuration, curve: curve)
          .slideY(
            begin: slideBegin,
            end: 0,
            duration: slideDuration,
            curve: curve,
          );
    }).toList();
  }

  /// Interest card grid stagger - 2-column aware (alternates delay per row).
  /// Left column items appear slightly before right column items.
  List<Widget> staggerGrid({
    int columns = 2,
    Duration rowInterval = const Duration(milliseconds: 120),
    Duration colOffset = const Duration(milliseconds: 60),
  }) {
    return asMap().entries.map((entry) {
      final index = entry.key;
      final widget = entry.value;
      final row = index ~/ columns;
      final col = index % columns;
      final delay = Duration(
        milliseconds:
            (row * rowInterval.inMilliseconds) +
            (col * colOffset.inMilliseconds),
      );
      return widget
          .animate(delay: delay)
          .fadeIn(duration: 300.ms, curve: Curves.easeOutCubic)
          .scale(
            begin: const Offset(0.85, 0.85),
            duration: 400.ms,
            curve: Curves.easeOutBack,
          );
    }).toList();
  }
}

/// Home screen greeting typewriter effect.
/// Per UI_UX.md 8.3: 40ms/char, cursor blink at end.
class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration charDuration;
  final VoidCallback? onComplete;

  const TypewriterText({
    super.key,
    required this.text,
    this.style,
    this.charDuration = const Duration(milliseconds: 40),
    this.onComplete,
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText>
    with SingleTickerProviderStateMixin {
  int _charCount = 0;
  late AnimationController _cursorController;
  bool _isComplete = false;

  @override
  void initState() {
    super.initState();
    _cursorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
    _startTyping();
  }

  void _startTyping() async {
    for (int i = 0; i <= widget.text.length; i++) {
      await Future.delayed(widget.charDuration);
      if (mounted) {
        setState(() => _charCount = i);
      }
    }
    if (mounted) {
      setState(() => _isComplete = true);
      widget.onComplete?.call();
    }
  }

  @override
  void dispose() {
    _cursorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(widget.text.substring(0, _charCount), style: widget.style),
        if (!_isComplete)
          FadeTransition(
            opacity: _cursorController,
            child: Text(
              '|',
              style: widget.style?.copyWith(color: const Color(0xFFF58220)),
            ),
          ),
      ],
    );
  }
}

/// Onboarding welcome sequence timing constants (UI_UX.md 8.2).
class OnboardingTiming {
  static const bgFadeIn = Duration(milliseconds: 0);
  static const bgFadeDuration = Duration(milliseconds: 600);
  static const sparkleIn = Duration(milliseconds: 200);
  static const sparkleDuration = Duration(milliseconds: 500);
  static const orbitDraw = Duration(milliseconds: 400);
  static const orbitDuration = Duration(milliseconds: 800);
  static const iconsStart = Duration(milliseconds: 600);
  static const iconsInterval = Duration(milliseconds: 100);
  static const logoTextIn = Duration(milliseconds: 1000);
  static const logoTextDuration = Duration(milliseconds: 300);
  static const headlineIn = Duration(milliseconds: 1200);
  static const headlineDuration = Duration(milliseconds: 400);
  static const subheadlineIn = Duration(milliseconds: 1400);
  static const subheadlineDuration = Duration(milliseconds: 400);
  static const buttonIn = Duration(milliseconds: 1600);
  static const buttonDuration = Duration(milliseconds: 500);
}
