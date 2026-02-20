import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _initializeAndNavigate(),
    );
  }

  Future<void> _initializeAndNavigate() async {
    // Start video initialization early (for onboarding)
    _videoController = VideoPlayerController.asset(
      'assets/images/onboarding.mp4',
    );
    final videoInitFuture = _videoController!.initialize().catchError((e) {
      debugPrint("Video initialization failed: $e");
      _videoController = null;
    });

    // 1. Minimum branding time (2 seconds) + video init
    await Future.wait([
      Future.delayed(const Duration(seconds: 2)),
      videoInitFuture,
    ]);

    if (!mounted) return;

    // 2. Check onboarding status
    final settingsBox = await Hive.openBox('settings');
    final isOnboarded =
        settingsBox.get('onboarding_complete', defaultValue: false) as bool;

    // 3. Check auth state
    final isAuthenticated = ref.read(authServiceProvider).isAuthenticated();

    // Clean up video if not going to onboarding
    if (isOnboarded) {
      _videoController?.dispose();
      _videoController = null;
    }

    if (!mounted) return;

    // 4. Navigate with fade-out
    Widget destination;
    if (!isOnboarded) {
      destination = OnboardingFlow(videoController: _videoController);
    } else if (!isAuthenticated) {
      // TODO: Replace with auth screen when available
      destination = const HomeScreen();
    } else {
      destination = const HomeScreen();
    }

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, _, _) => destination,
        transitionsBuilder: (_, animation, _, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF8F0FF), // Soft lavender
              Color(0xFFE8F4FD), // Soft blue
              Color(0xFFFFF8F0), // Warm cream
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // --- Logo: Orange squircle with sparkle star ---
              Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFF58220), Color(0xFFF7A94B)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24), // Squircle
                      boxShadow: [
                        BoxShadow(
                          color: const Color(
                            0xFFF58220,
                          ).withValues(alpha: 0.25),
                          blurRadius: 32,
                          spreadRadius: 4,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.auto_awesome,
                      color: Colors.white,
                      size: 52,
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .scale(
                    begin: const Offset(0.8, 0.8),
                    end: const Offset(1.0, 1.0),
                    duration: 300.ms,
                    delay: 200.ms,
                    curve: Curves.easeOutBack,
                  ),

              const SizedBox(height: 28),

              // --- "Sathio" text ---
              Text(
                    'Sathio',
                    style: GoogleFonts.inter(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF111111),
                      letterSpacing: 1.5,
                    ),
                  )
                  .animate(delay: 700.ms)
                  .fadeIn(duration: 400.ms)
                  .slideY(
                    begin: 0.15,
                    end: 0,
                    duration: 400.ms,
                    curve: Curves.easeOut,
                  ),

              const SizedBox(height: 8),

              // --- "Main hoon na" tagline ---
              Text(
                    'Main hoon na',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF666666),
                      letterSpacing: 0.5,
                    ),
                  )
                  .animate(delay: 1000.ms)
                  .fadeIn(duration: 400.ms)
                  .slideY(
                    begin: 0.15,
                    end: 0,
                    duration: 400.ms,
                    curve: Curves.easeOut,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
