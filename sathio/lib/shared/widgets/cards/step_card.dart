import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../buttons/buttons.dart';

class StepCard extends StatelessWidget {
  final int stepNumber;
  final String instruction;
  final bool isActive;
  final VoidCallback? onPlay;
  final bool isPlaying;

  const StepCard({
    super.key,
    required this.stepNumber,
    required this.instruction,
    this.isActive = false,
    this.onPlay,
    this.isPlaying = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
        border: isActive
            ? const Border(left: BorderSide(color: Color(0xFFF58220), width: 3))
            : null,
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step Badge
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: Color(0xFFF58220),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              stepNumber.toString(),
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Instruction Text
          Expanded(
            child: Text(
              instruction,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF111111),
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Play Button
          if (onPlay != null)
            CircularIconButton(
              onPressed: onPlay!,
              icon: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                color: const Color(0xFF111111),
                size: 20,
              ),
              backgroundColor: Colors.white,
            ),
        ],
      ),
    );
  }
}
