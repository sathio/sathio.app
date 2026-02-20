import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Data model for each orbiting icon
class _OrbitIcon {
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final double orbitRadius; // normalized (1.0 = maxOrbitRadius)
  final double startAngle; // initial angle in radians
  final double size;
  final double speed; // positive = CW, negative = CCW

  const _OrbitIcon({
    required this.icon,
    required this.bgColor,
    required this.iconColor,
    required this.orbitRadius,
    required this.startAngle,
    required this.size,
    required this.speed,
  });
}

class OnboardingScreen extends StatefulWidget {
  final VoidCallback? onGetStarted;
  const OnboardingScreen({super.key, this.onGetStarted});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _orbitController;

  // ── Icon definitions ──
  // 3 rings: inner (~0.42), middle (~0.72), outer (~1.0)
  // Icons are larger, more colorful, with solid fills like Luma
  final List<_OrbitIcon> _icons = [
    // ── Outer ring (CCW) ──
    const _OrbitIcon(
      icon: Icons.location_on_rounded,
      bgColor: Color(0xFFE88DD6), // pink
      iconColor: Colors.white,
      orbitRadius: 1.05,
      startAngle: -0.3,
      size: 54,
      speed: -0.6,
    ),
    const _OrbitIcon(
      icon: Icons.volunteer_activism_rounded,
      bgColor: Color(0xFFFF7C6B), // coral
      iconColor: Colors.white,
      orbitRadius: 1.0,
      startAngle: 1.2 * pi,
      size: 50,
      speed: -0.7,
    ),
    const _OrbitIcon(
      icon: Icons.public_rounded,
      bgColor: Color(0xFFAB7AE8), // lavender
      iconColor: Colors.white,
      orbitRadius: 1.08,
      startAngle: 0.55 * pi,
      size: 52,
      speed: -0.55,
    ),
    const _OrbitIcon(
      icon: Icons.people_alt_rounded,
      bgColor: Color(0xFF5BBFA0), // mint
      iconColor: Colors.white,
      orbitRadius: 0.95,
      startAngle: 1.7 * pi,
      size: 48,
      speed: -0.65,
    ),

    // ── Middle ring (CW) ──
    const _OrbitIcon(
      icon: Icons.calendar_month_rounded,
      bgColor: Color(0xFF6C7AE8), // periwinkle
      iconColor: Colors.white,
      orbitRadius: 0.72,
      startAngle: 0.85 * pi,
      size: 56,
      speed: 0.8,
    ),
    const _OrbitIcon(
      icon: Icons.celebration_rounded,
      bgColor: Color(0xFFFF9B5E), // orange
      iconColor: Colors.white,
      orbitRadius: 0.68,
      startAngle: 1.85 * pi,
      size: 50,
      speed: 0.9,
    ),
    const _OrbitIcon(
      icon: Icons.person_rounded,
      bgColor: Color(0xFF5EB8E8), // sky blue
      iconColor: Colors.white,
      orbitRadius: 0.75,
      startAngle: 0.2 * pi,
      size: 48,
      speed: 0.75,
    ),

    // ── Inner ring (CCW) ──
    const _OrbitIcon(
      icon: Icons.account_balance_rounded,
      bgColor: Color(0xFF4DA6E8), // blue
      iconColor: Colors.white,
      orbitRadius: 0.42,
      startAngle: 0.4 * pi,
      size: 44,
      speed: -1.0,
    ),
    const _OrbitIcon(
      icon: Icons.mic_rounded,
      bgColor: Color(0xFF4DBFA5), // teal
      iconColor: Colors.white,
      orbitRadius: 0.38,
      startAngle: 1.4 * pi,
      size: 42,
      speed: -1.1,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 80), // very slow, elegant drift
    )..repeat();
  }

  @override
  void dispose() {
    _orbitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    // ── Layout constants (tuned to match Luma's proportions) ──
    // Center the orbit system at ~35% from the top (like Luma)
    final centerY = screenSize.height * 0.35;
    final centerX = screenSize.width / 2;
    // maxOrbitRadius large enough so outer icons clip off edges
    final maxOrbitRadius = screenSize.width * 0.52;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA), // very slight off-white
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          // ── Layer 1: Subtle radial vignette ──
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.1,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.025),
                    Colors.black.withValues(alpha: 0.08),
                  ],
                  stops: const [0.0, 0.55, 0.85, 1.0],
                ),
              ),
            ),
          ),

          // ── Layer 2: Concentric orbit rings (thicker, like Luma) ──
          Positioned(
            left: centerX - maxOrbitRadius * 1.1,
            top: centerY - maxOrbitRadius * 1.1,
            child: SizedBox(
              width: maxOrbitRadius * 2.2,
              height: maxOrbitRadius * 2.2,
              child: CustomPaint(painter: _OrbitRingsPainter()),
            ),
          ),

          // ── Layer 3: Orbiting icons ──
          AnimatedBuilder(
            animation: _orbitController,
            builder: (context, child) {
              return Stack(
                clipBehavior: Clip.none,
                children: _icons.map((orbitIcon) {
                  final angle =
                      orbitIcon.startAngle +
                      (_orbitController.value *
                          2 *
                          pi *
                          orbitIcon.speed *
                          0.12);
                  final radius = maxOrbitRadius * orbitIcon.orbitRadius;

                  final x = centerX + radius * cos(angle) - orbitIcon.size / 2;
                  final y = centerY + radius * sin(angle) - orbitIcon.size / 2;

                  return Positioned(
                    left: x,
                    top: y,
                    child: _buildOrbitingIcon(orbitIcon),
                  );
                }).toList(),
              );
            },
          ),

          // ── Layer 4: Center logo with glowing halo ──
          Positioned(
            left: centerX - 48,
            top: centerY - 48,
            child: Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF8A50).withValues(alpha: 0.18),
                    blurRadius: 40,
                    spreadRadius: 8,
                  ),
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.9),
                    blurRadius: 20,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: ClipOval(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Image.asset(
                    'assets/images/sathio_logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),

          // ── Layer 5: Bottom text + button (tighter to orbit) ──
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.fromLTRB(28, 0, 28, 48),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Small "sathio" label
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'sathio',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFAAAAAA),
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '+',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFCCCCCC),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    // Main heading — large, bold
                    Text(
                      'Your Digital Tasks',
                      style: GoogleFonts.inter(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1A1A1A),
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    // Gradient accent line
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Color(0xFFFFB74D), Color(0xFFFF7043)],
                      ).createShader(bounds),
                      child: Text(
                        'Start Here',
                        style: GoogleFonts.inter(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Get Started button
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: () {
                          widget.onGetStarted?.call();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1A1A1A),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: const StadiumBorder(),
                        ),
                        child: Text(
                          'Get Started',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a single Luma-style orbiting icon bubble:
  /// solid colored circle + white icon + drop shadow
  Widget _buildOrbitingIcon(_OrbitIcon orbitIcon) {
    return Container(
      width: orbitIcon.size,
      height: orbitIcon.size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: orbitIcon.bgColor,
        boxShadow: [
          BoxShadow(
            color: orbitIcon.bgColor.withValues(alpha: 0.35),
            blurRadius: 14,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(
        orbitIcon.icon,
        color: orbitIcon.iconColor,
        size: orbitIcon.size * 0.48,
      ),
    );
  }
}

/// Paints concentric orbit ring circles — thicker stroke to match Luma
class _OrbitRingsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2;

    // 3 rings with thicker stroke
    final rings = [
      const _RingSpec(0.38, 1.8, Color(0xFFE8E8E8)), // inner
      const _RingSpec(0.65, 2.2, Color(0xFFE0E0E0)), // middle
      const _RingSpec(0.92, 2.5, Color(0xFFD8D8D8)), // outer
    ];

    for (final ring in rings) {
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = ring.strokeWidth
        ..color = ring.color.withValues(alpha: 0.45);
      canvas.drawCircle(center, maxRadius * ring.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _RingSpec {
  final double radius;
  final double strokeWidth;
  final Color color;
  const _RingSpec(this.radius, this.strokeWidth, this.color);
}
