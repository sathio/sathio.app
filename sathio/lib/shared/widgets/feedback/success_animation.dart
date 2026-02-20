import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessAnimation extends StatelessWidget {
  final String? text;
  final bool showConfetti;
  final VoidCallback? onAnimationComplete;

  const SuccessAnimation({
    super.key,
    this.text,
    this.showConfetti = true,
    this.onAnimationComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 120,
          height: 120,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (showConfetti) ..._buildConfetti(),
              // Checkmark Circle
              Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: Color(0xFF4CAF50), // Green 500
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 48,
                    ),
                  )
                  .animate(onComplete: (_) => onAnimationComplete?.call())
                  .scale(
                    duration: 600.ms,
                    curve: Curves.elasticOut,
                    begin: const Offset(0, 0),
                  )
                  .then()
                  .shimmer(
                    duration: 1200.ms,
                    color: Colors.white.withValues(alpha: 0.4),
                  ),
            ],
          ),
        ),
        if (text != null) ...[
          const SizedBox(height: 16),
          Text(
                text!,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF111111),
                ),
                textAlign: TextAlign.center,
              )
              .animate()
              .fadeIn(delay: 400.ms, duration: 400.ms)
              .slideY(begin: 0.2, end: 0, curve: Curves.easeOut),
        ],
      ],
    );
  }

  List<Widget> _buildConfetti() {
    // Simple confetti simulation using Animate
    // Scattered small circles
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
    ];
    final offsets = [
      const Offset(-40, -40),
      const Offset(40, -30),
      const Offset(-30, 40),
      const Offset(30, 50),
      const Offset(0, -50),
    ];

    return List.generate(5, (index) {
      return Positioned(
        child:
            Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: colors[index % colors.length],
                    shape: BoxShape.circle,
                  ),
                )
                .animate(delay: 200.ms)
                .scale(duration: 100.ms, begin: const Offset(0, 0))
                .move(
                  duration: 600.ms,
                  begin: const Offset(0, 0),
                  end: offsets[index],
                  curve: Curves.easeOutQuad,
                )
                .fadeOut(delay: 400.ms, duration: 300.ms),
      );
    });
  }
}
