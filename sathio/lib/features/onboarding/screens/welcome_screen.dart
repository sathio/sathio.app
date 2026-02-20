import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // For sequence animations
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import '../../../../shared/widgets/buttons/buttons.dart';

class WelcomeScreen extends StatefulWidget {
  final Future<void> Function()? onGetStarted;
  final VideoPlayerController? videoController;
  final bool shouldPlay; // New prop

  const WelcomeScreen({
    super.key,
    this.onGetStarted,
    this.videoController,
    this.shouldPlay = true,
  });

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with AutomaticKeepAliveClientMixin {
  late VideoPlayerController _controller;
  bool _isControllerOwner = false;
  bool _hasError = false;

  @override
  bool get wantKeepAlive => true; // Keep screen alive to preserve video state/buffer

  @override
  void initState() {
    super.initState();
    // Use preloaded controller if available, otherwise create new one
    if (widget.videoController != null) {
      _controller = widget.videoController!;
      _isControllerOwner = false;
    } else {
      _controller = VideoPlayerController.asset('assets/images/onboarding.mp4');
      _isControllerOwner = true;
    }

    // Listen for initialization state changes to trigger rebuild
    _controller.addListener(_onControllerUpdate);
    _configureController();
  }

  void _onControllerUpdate() {
    if (mounted) {
      // Rebuild when video state changes (initialized, errors, etc.)
      setState(() {});
    }
  }

  @override
  void didUpdateWidget(WelcomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shouldPlay != oldWidget.shouldPlay) {
      if (widget.shouldPlay) {
        if (_controller.value.isInitialized) {
          _controller.play();
        }
      } else {
        _controller.pause();
      }
    }
  }

  void _configureController() {
    _controller.setVolume(0);
    _controller.setLooping(true);

    if (_controller.value.isInitialized) {
      // Already initialized (pre-loaded from SplashScreen)
      if (widget.shouldPlay) _controller.play();
    } else {
      // Initialize now
      _controller
          .initialize()
          .then((_) {
            if (mounted) {
              setState(() {});
              if (widget.shouldPlay) _controller.play();
            }
          })
          .catchError((e) {
            debugPrint('Video initialization failed: $e');
            if (mounted) {
              setState(() {
                _hasError = true;
              });
            }
          });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerUpdate);
    if (_isControllerOwner) {
      _controller.dispose();
    } else {
      // If we don't own it, just pause it so it doesn't play in background
      _controller.pause();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF8F0FF), // Top-left
              Color(0xFFE8F4FD), // Centerish
              Color(0xFFFFF8F0), // Bottom-right
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // --- Video Background / Animation ---
            if (_controller.value.isInitialized)
              Positioned.fill(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                ),
              )
            else if (!_hasError)
              const Center(child: CircularProgressIndicator()),
            // If _hasError, the underlying gradient container shows through

            // --- Subtle Pastel Gradient Overlay (Luma-inspired) ---
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(-0.8, -0.6),
                    radius: 1.8,
                    colors: [
                      const Color(
                        0xFFE8DEFF,
                      ).withValues(alpha: 0.18), // Lavender
                      const Color(
                        0xFFD6EEFF,
                      ).withValues(alpha: 0.12), // Light blue
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.3, 0.7],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(0.9, 0.7),
                    radius: 1.4,
                    colors: [
                      const Color(
                        0xFFFFE8D6,
                      ).withValues(alpha: 0.16), // Warm peach
                      const Color(
                        0xFFFFF0E8,
                      ).withValues(alpha: 0.10), // Soft cream
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.35, 0.7],
                  ),
                ),
              ),
            ),

            // --- Bottom Content (Text + Button) ---
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 32.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo Image
                      const SizedBox(height: 12),
                      Image.asset(
                        'assets/images/sathio.png',
                        height: 80,
                        color: Colors.grey,
                        colorBlendMode: BlendMode.srcIn,
                      ).animate().fadeIn(duration: 600.ms),

                      const SizedBox(height: 1),

                      // Headline
                      Text(
                            'Your Digital Companion',
                            style: GoogleFonts.poppins(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF111111),
                              height: 1.2,
                            ),
                            textAlign: TextAlign.center,
                          )
                          .animate(delay: 200.ms)
                          .fadeIn(duration: 600.ms)
                          .slideY(begin: 0.2, end: 0),

                      const SizedBox(height: 2),

                      // Subheadline with Gradient
                      ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [
                                Color(0xFFFFC107), // Yellow/Amber
                                Color(0xFFF57C00), // Orange
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ).createShader(bounds),
                            child: Text(
                              'Start Here',
                              style: GoogleFonts.poppins(
                                fontSize: 34,
                                fontWeight: FontWeight.w600,
                                color: Colors.white, // Required for ShaderMask
                                height: 1.2,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                          .animate(delay: 400.ms)
                          .fadeIn(duration: 600.ms)
                          .slideY(begin: 0.2, end: 0),

                      const SizedBox(height: 24),

                      // Get Started Button
                      Animate(
                        delay: 600.ms,
                        effects: [
                          SlideEffect(
                            begin: const Offset(0, 1.0),
                            end: Offset.zero,
                            duration: 600.ms,
                            curve: Curves.easeOutBack,
                          ),
                        ],
                        child: PrimaryButton(
                          onPressed: () {
                            if (widget.onGetStarted != null) {
                              widget.onGetStarted!();
                            }
                          },
                          text: 'Get Started',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
