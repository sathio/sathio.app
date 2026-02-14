import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import '../../../../services/auth/auth_provider.dart';
import '../../home/screens/home_screen.dart';
import 'onboarding_flow.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  VideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _handleNavigation());
  }

  Future<void> _handleNavigation() async {
    // Start video initialization early
    _videoController = VideoPlayerController.asset(
      'assets/images/onboarding.mp4',
    );
    final videoInitFuture = _videoController!.initialize().catchError((e) {
      debugPrint("Video initialization failed: $e");
      // Handle error by setting controller to null or just proceeding
      _videoController = null;
    });

    // 1. Minimum Branding Time (2 seconds)
    // Wait for both the minimum timer AND video init (to avoid pop-in)
    await Future.wait([
      Future.delayed(const Duration(seconds: 2)),
      videoInitFuture,
    ]);

    if (!mounted) return;

    // 2. Check Auth State - synchronous check of persisted session
    final isAuthenticated = ref.read(authServiceProvider).isAuthenticated();

    // Clean up if we're not going to show the video (user is logged in)
    if (isAuthenticated) {
      _videoController?.dispose();
      _videoController = null;
    }

    // 3. Navigate
    // Using PageRouteBuilder for a custom fade transition
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, _, _) => isAuthenticated
            ? const HomeScreen()
            : OnboardingFlow(videoController: _videoController),
        transitionsBuilder: (_, animation, _, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 800),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // --- Logo ---
            // Simulating Luma's sparkle with a gradient circle + icon for now
            // until actual assets are ready.
            Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFFF58220), Color(0xFFF7A94B)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    color: Colors.white,
                    size: 48,
                  ),
                )
                .animate()
                .scale(
                  duration: 600.ms,
                  curve: Curves.elasticOut,
                  begin: const Offset(0, 0),
                  end: const Offset(1, 1),
                )
                .then()
                .rotate(
                  // Subtle rotation loop
                  duration: 2000.ms,
                  begin: -0.03, // approx -10 deg
                  end: 0.03, // approx 10 deg
                  curve: Curves.easeInOut,
                )
                .then() // Loop the sway back and forth?
                // flutter_animate loop restarts animation; simpler to just reverse?
                // Actually, to make it sway back and forth cleanly:
                .rotate(
                  duration: 2000.ms,
                  begin: 0.03,
                  end: -0.03,
                  curve: Curves.easeInOut,
                ),

            const SizedBox(height: 24),

            // --- Text ---
            Text(
                  'sathio',
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF111111),
                    letterSpacing: 1.2,
                  ),
                )
                .animate(delay: 400.ms) // Wait for logo to pop
                .fadeIn(duration: 600.ms)
                .slideY(
                  begin: 0.2,
                  end: 0,
                  duration: 600.ms,
                  curve: Curves.easeOut,
                ),
          ],
        ),
      ),
    );
  }
}
