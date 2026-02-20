import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LanguagePill extends StatelessWidget {
  final String languageCode; // e.g., 'HI' for Hindi, 'EN' for English
  final String flagEmoji; // e.g., '🇮🇳'
  final VoidCallback onTap;

  const LanguagePill({
    super.key,
    required this.languageCode,
    required this.flagEmoji,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE0E0E0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(flagEmoji, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 6),
            Text(
              languageCode.toUpperCase(),
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF333333),
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 16,
              color: Color(0xFF666666),
            ),
          ],
        ),
      ),
    );
  }
}
