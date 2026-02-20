import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

enum WaveformSize { small, medium, large }

class LoadingWaveform extends StatelessWidget {
  final WaveformSize size;
  final String? text;
  final Color color;

  const LoadingWaveform({
    super.key,
    this.size = WaveformSize.medium,
    this.text,
    this.color = Colors.teal,
  });

  @override
  Widget build(BuildContext context) {
    double barWidth;
    double maxHeight;
    double fontSize;

    switch (size) {
      case WaveformSize.small:
        barWidth = 4;
        maxHeight = 24;
        fontSize = 12;
        break;
      case WaveformSize.medium:
        barWidth = 6;
        maxHeight = 40;
        fontSize = 14;
        break;
      case WaveformSize.large:
        barWidth = 8;
        maxHeight = 60;
        fontSize = 18;
        break;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return Container(
                  margin: EdgeInsets.symmetric(horizontal: barWidth / 2),
                  width: barWidth,
                  height: maxHeight,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(barWidth),
                  ),
                )
                .animate(
                  onPlay: (controller) => controller.repeat(reverse: true),
                )
                .scaleY(
                  begin: 0.2,
                  end: 1.0,
                  curve: Curves.easeInOut,
                  duration: 600.ms,
                  delay: (index * 100).ms,
                );
          }),
        ),
        if (text != null) ...[
          const SizedBox(height: 16),
          Text(
            text!,
            style: GoogleFonts.inter(
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF666666),
            ),
          ),
        ],
      ],
    );
  }
}
