import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Mic button animation helpers per UI_UX.md Section 8.5.
///
/// State machine:
/// IDLE ──tap──→ LISTENING ──stop──→ PROCESSING ──done──→ SPEAKING ──end──→ IDLE

enum MicAnimationState { idle, listening, processing, speaking, error }

/// Breathing glow for idle mic button.
/// Orange shadow pulses: radius 8→16→8dp, opacity 0.3→0.5→0.3, 2s loop.
class MicBreathingGlow extends StatelessWidget {
  final Widget child;

  const MicBreathingGlow({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .custom(
          duration: 2000.ms,
          curve: Curves.easeInOut,
          builder: (context, value, child) {
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(
                      0xFFF58220,
                    ).withValues(alpha: 0.3 + (0.2 * value)),
                    blurRadius: 8 + (8 * value),
                    spreadRadius: 2 + (4 * value),
                  ),
                ],
              ),
              child: child,
            );
          },
        );
  }
}

/// Mic tap animation: scale 1.0→1.15→1.0 + haptic.
class MicTapEffect extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const MicTapEffect({super.key, required this.child, required this.onTap});

  @override
  State<MicTapEffect> createState() => _MicTapEffectState();
}

class _MicTapEffectState extends State<MicTapEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.15), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.15, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        _controller.forward(from: 0);
        widget.onTap();
      },
      child: ScaleTransition(scale: _scaleAnimation, child: widget.child),
    );
  }
}

/// Listening waveform: 5 bars, height varies with audio amplitude.
/// Orange gradient, animated at 60fps.
class ListeningWaveform extends StatefulWidget {
  final double amplitude; // 0.0 to 1.0
  final Color color;

  const ListeningWaveform({
    super.key,
    required this.amplitude,
    this.color = const Color(0xFFF58220),
  });

  @override
  State<ListeningWaveform> createState() => _ListeningWaveformState();
}

class _ListeningWaveformState extends State<ListeningWaveform>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(5, (index) {
            final phase = index * 0.4;
            final value = math
                .sin((_controller.value * 2 * math.pi) + phase)
                .abs();
            final amplitude = widget.amplitude.clamp(0.1, 1.0);
            final barHeight = 8 + (32 * value * amplitude);

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: 6,
              height: barHeight,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [widget.color, widget.color.withValues(alpha: 0.6)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }),
        );
      },
    );
  }
}

/// Processing dots: 3 bouncing dots (staggered 150ms), scale 0.5→1.0 loop.
class ProcessingDots extends StatelessWidget {
  final Color color;

  const ProcessingDots({super.key, this.color = const Color(0xFFF58220)});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            )
            .animate(
              onPlay: (c) => c.repeat(reverse: true),
              delay: Duration(milliseconds: index * 150),
            )
            .scaleXY(
              begin: 0.5,
              end: 1.0,
              duration: 400.ms,
              curve: Curves.easeInOut,
            );
      }),
    );
  }
}

/// Error shake: translateX [-8, 8, -6, 6, -3, 0] + red flash overlay.
class MicErrorShake extends StatelessWidget {
  final Widget child;

  const MicErrorShake({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child
        .animate()
        .shake(duration: 300.ms, hz: 6, offset: const Offset(8, 0))
        .then()
        .tint(color: Colors.red.withValues(alpha: 0.3), duration: 150.ms)
        .then()
        .tint(color: Colors.transparent, duration: 150.ms);
  }
}
