import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // For sequence animations
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

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
      _controller = VideoPlayerController.asset(
        'assets/images/onboarding.webm',
      );
      _isControllerOwner = true;
    }

    _configureController();
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
    // Mute audio to allow autoplay on web/iOS
    _controller.setVolume(0);
    _controller.setLooping(true);

    if (_controller.value.isInitialized) {
      if (widget.shouldPlay) _controller.play();
    } else {
      _controller.initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized
        if (mounted) {
          setState(() {});
          if (widget.shouldPlay) _controller.play();
        }
      });
    }
  }

  @override
  void dispose() {
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
            else
              const Center(child: CircularProgressIndicator()),

            // --- Bottom Content (Text + Button) ---
            Positioned(
              left: 0,
              right: 0,
              bottom: MediaQuery.of(context).size.height * 0.08,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 32.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo Text
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'sathio',
                            style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ).animate().fadeIn(duration: 600.ms),

                      const SizedBox(height: 16),

                      // Headline
                      Text(
                            'Your Digital Companion',
                            style: GoogleFonts.poppins(
                              fontSize: 28,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF111111),
                              height: 1.2,
                            ),
                            textAlign: TextAlign.center,
                          )
                          .animate(delay: 200.ms)
                          .fadeIn(duration: 600.ms)
                          .slideY(begin: 0.2, end: 0),

                      const SizedBox(height: 8),

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
                              'Start Your Journey Here',
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                color: Colors.white, // Required for ShaderMask
                                height: 1.2,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                          .animate(delay: 400.ms)
                          .fadeIn(duration: 600.ms)
                          .slideY(begin: 0.2, end: 0),

                      const SizedBox(height: 48),

                      // Get Started Button
                      SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: () {
                                if (widget.onGetStarted != null) {
                                  widget.onGetStarted!();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF111111),
                                foregroundColor: Colors.white,
                                elevation: 5,
                                shadowColor: Colors.black.withValues(
                                  alpha: 0.2,
                                ),
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
                          )
                          .animate(delay: 600.ms)
                          .slideY(
                            begin: 1.0,
                            end: 0,
                            duration: 600.ms,
                            curve: Curves.easeOutBack,
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
