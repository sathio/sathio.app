import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isOrange;
  final double? fontSize;

  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isOrange = false,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: isOrange
            ? const Color(0xFFF58220)
            : const Color(0xFF666666),
        splashFactory: NoSplash.splashFactory, // cleaner look
        overlayColor: Colors.transparent,
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: fontSize ?? 14,
          fontWeight: FontWeight.w500,
          color: isOrange ? const Color(0xFFF58220) : const Color(0xFF666666),
        ),
      ),
    );
  }
}
