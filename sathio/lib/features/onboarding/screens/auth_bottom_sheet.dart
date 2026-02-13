import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthBottomSheet extends StatelessWidget {
  final VoidCallback onPhoneTap;
  final VoidCallback onGoogleTap;
  final VoidCallback onGuestTap;

  const AuthBottomSheet({
    super.key,
    required this.onPhoneTap,
    required this.onGoogleTap,
    required this.onGuestTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Handle Bar
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFD0D0D0),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              const SizedBox(height: 16),

              // Header Row with Close Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Sparkle Icon
                  // Sparkle Icon
                  const Icon(
                    Icons.auto_awesome,
                    color: Color(0xFF999999),
                    size: 28,
                  ),
                  // Close Button
                  IconButton(
                    icon: const Icon(Icons.close, color: Color(0xFF999999)),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Title
              Text(
                "Let's Get Started",
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF111111),
                ),
              ),

              const SizedBox(height: 8),

              // Description
              Text(
                "Sathio handles your digital tasks. Sign in to begin.",
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF666666),
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 32),

              // 1. Phone Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: onPhoneTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF111111),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.phone_rounded, size: 20),
                      const SizedBox(width: 12),
                      Text(
                        'Continue with Phone',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // 2. Google Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  onPressed: onGoogleTap,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFFF5F5F5),
                    foregroundColor: const Color(0xFF333333),
                    side: const BorderSide(color: Color(0xFFE0E0E0)),
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Google Icon (using generic for now or font awesome if available, else Icon)
                      // Using a placeholder icon or text G if no asset
                      // Assuming no SVG asset yet, using text or simple icon
                      const Icon(
                        Icons.g_mobiledata,
                        size: 28,
                        color: Color(0xFFF58220),
                      ), // Placeholder for G logo
                      const SizedBox(width: 8),
                      Text(
                        'Continue with Google',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 3. Guest Link
              GestureDetector(
                onTap: onGuestTap,
                child: Text(
                  'Continue as Guest',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF666666),
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
