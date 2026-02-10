import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart'; // Re-adding import
import '../onboarding_provider.dart';

class StartScreen extends ConsumerStatefulWidget {
  const StartScreen({super.key});

  @override
  ConsumerState<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends ConsumerState<StartScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Colors from darkest to lightest
    final circleColors = [
      const Color(0xFFF34E0A), // Darkest
      const Color(0xFFF26F39),
      const Color(0xFFFFBA9D),
      const Color(0xFFFEE5DB), // Lightest
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFBF4E2),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),

            // Namaste Logo PNG
            Center(
              child: Image.asset(
                'assets/icons/namaste.png',
                height: 120, // Increased size
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Text(
                    'Error loading image',
                    style: TextStyle(color: Colors.red),
                  );
                },
              ),
            ),

            const SizedBox(height: 5), // Reduced spacing
            // Subtitle
            Text(
              'I am Sathio, your personal assistant',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, // Thicker
                fontSize: 18,
                color: Colors.black,
                letterSpacing: -0.5,
              ),
            ),

            const Spacer(flex: 3),

            // Breathing Circles
            Center(
              child: AnimatedBuilder(
                animation: _scaleAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: SizedBox(
                      width: 300,
                      height: 300,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          _buildCircle(280, circleColors[0]), // Darkest
                          _buildCircle(220, circleColors[1]),
                          _buildCircle(160, circleColors[2]),
                          _buildCircle(100, circleColors[3]), // Lightest
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const Spacer(flex: 3),

            // Bottom Arrow Button
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: GestureDetector(
                onTap: () {
                  ref.read(onboardingProvider.notifier).nextPage();
                },
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFBA9D),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.black, // High contrast
                    size: 28,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
