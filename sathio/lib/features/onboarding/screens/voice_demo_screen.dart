import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/asset_paths.dart';
import '../onboarding_provider.dart';

class VoiceDemoScreen extends ConsumerStatefulWidget {
  const VoiceDemoScreen({super.key});

  @override
  ConsumerState<VoiceDemoScreen> createState() => _VoiceDemoScreenState();
}

class _VoiceDemoScreenState extends ConsumerState<VoiceDemoScreen> {
  final FlutterTts flutterTts = FlutterTts();

  bool _isListening = false;
  bool _hasSpoken = false;
  bool _isSuccess = false;
  String _statusText = "Tap the mic and say:\n\"Namaste Sathio\"";

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  Future<void> _initTts() async {
    try {
      await flutterTts.setLanguage("en-IN");
      await flutterTts.setSpeechRate(0.85);
      await flutterTts.setPitch(1.0);
      await flutterTts.setVolume(1.0);
    } catch (e) {
      debugPrint("Error initializing TTS: $e");
    }
  }

  Future<void> _startDemo() async {
    setState(() {
      _isListening = true;
      _statusText = "Listening...";
    });

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      _isListening = false;
      _hasSpoken = true;
      _statusText = "Namaste Sathio";
    });

    await flutterTts.speak("Namaste! I can hear you. Great!");

    setState(() {
      _isSuccess = true;
    });
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.orange,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top 30%: Orange header
          Expanded(
            flex: 3,
            child: SafeArea(
              bottom: false,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Voice',
                        style: GoogleFonts.poppins(
                          fontSize: 64,
                          height: 1.0,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFFFBF4E2),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'See how I work',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.9),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Bottom 70%: Cream panel
          Expanded(
            flex: 7,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFFBF4E2), // Cream
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Main content centered
                  Center(
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Status Text
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: Text(
                                _statusText,
                                key: ValueKey(_statusText),
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: _hasSpoken
                                      ? FontWeight.bold
                                      : FontWeight.w400,
                                  color: _hasSpoken
                                      ? AppColors.orange
                                      : Colors.black87,
                                  height: 1.3,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),

                            const SizedBox(height: 48),

                            // Mic Button
                            GestureDetector(
                              onTap: _isListening || _isSuccess
                                  ? null
                                  : _startDemo,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Outer Ripple
                                  if (_isListening)
                                    Container(
                                          width: 200,
                                          height: 200,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.orange.withOpacity(
                                              0.1,
                                            ),
                                          ),
                                        )
                                        .animate(onPlay: (c) => c.repeat())
                                        .scale(
                                          begin: const Offset(0.8, 0.8),
                                          end: const Offset(1.2, 1.2),
                                          duration: 1.seconds,
                                        )
                                        .fadeOut(duration: 1.seconds),

                                  // Main Button
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _isListening
                                          ? Colors.white
                                          : (_isSuccess
                                                ? Colors.green
                                                : AppColors.orange),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              (_isListening
                                                      ? Colors.black12
                                                      : (_isSuccess
                                                            ? Colors.green
                                                            : AppColors.orange))
                                                  .withOpacity(0.3),
                                          blurRadius: 20,
                                          spreadRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: _isListening
                                          ? Lottie.asset(
                                              AssetPaths.listeningAnim,
                                              width: 80,
                                            )
                                          : (_isSuccess
                                                ? const Icon(
                                                    Icons.check,
                                                    size: 60,
                                                    color: Colors.white,
                                                  ).animate().scale()
                                                : const Icon(
                                                    Icons.mic,
                                                    size: 60,
                                                    color: Colors.white,
                                                  )),
                                    ),
                                  ),

                                  // Success Anim Overlay
                                  if (_isSuccess)
                                    Positioned.fill(
                                      child: Lottie.asset(
                                        AssetPaths.successAnim,
                                        repeat: false,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                ],
                              ),
                            ).animate().scale(
                              curve: Curves.easeOutBack,
                              duration: 500.ms,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Footer Actions (Skip / Continue)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Skip Text (Center if alone, Left if FAB exists)
                          if (!_isSuccess)
                            Expanded(
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    ref
                                        .read(onboardingProvider.notifier)
                                        .nextPage();
                                  },
                                  child: Text(
                                    'Try later',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: AppColors.orange.withOpacity(0.7),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ).animate().fadeIn(delay: 1.seconds),
                              ),
                            )
                          else
                            const SizedBox(), // Spacer if needed
                          // FAB (Right)
                          if (_isSuccess)
                            GestureDetector(
                              onTap: () {
                                ref
                                    .read(onboardingProvider.notifier)
                                    .nextPage();
                              },
                              child: Container(
                                width: 64,
                                height: 64,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.black,
                                  size: 28,
                                ),
                              ),
                            ).animate().scale(
                              duration: 300.ms,
                              curve: Curves.easeOutBack,
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
