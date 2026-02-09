import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lottie/lottie.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/utils/extensions.dart';
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
  String _statusText = "Mic button dabao aur bolo:\n\"Namaste Sathio\"";

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  Future<void> _initTts() async {
    await flutterTts.setLanguage("hi-IN");
    await flutterTts.setSpeechRate(0.85); // Slower for clarity
    await flutterTts.setPitch(1.0); // Natural pitch
    await flutterTts.setVolume(1.0);
  }

  Future<void> _startDemo() async {
    setState(() {
      _isListening = true;
      _statusText = "Sun raha hoon...";
    });

    // Simulate listening delay
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      _isListening = false;
      _hasSpoken = true;
      _statusText = "Namaste Sathio";
    });

    // Speak response
    await flutterTts.speak("Namaste! Main sun sakta hoon. Bahut badhiya!");

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
      backgroundColor: context.colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.xl),

              Text(
                'Dekho main kaise kaam karta hoon',
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryLight,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn().slideY(begin: -0.2, end: 0),

              const Spacer(),

              // Status Text / Instruction
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  _statusText,
                  key: ValueKey(_statusText),
                  style: context.textTheme.headlineSmall?.copyWith(
                    fontWeight: _hasSpoken
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: _hasSpoken
                        ? AppColors.primary
                        : AppColors.textPrimaryLight,
                    height: 1.3,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: AppSpacing.xxl),

              // Mic Button / Animation Centerpiece
              GestureDetector(
                onTap: _isListening || _isSuccess ? null : _startDemo,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outer Ripple (when listening)
                    if (_isListening)
                      Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary.withOpacity(0.1),
                            ),
                          )
                          .animate(onPlay: (c) => c.repeat())
                          .scale(
                            begin: const Offset(0.8, 0.8),
                            end: const Offset(1.2, 1.2),
                            duration: 1.seconds,
                          )
                          .fadeOut(duration: 1.seconds),

                    // Main Button/Animation Container
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _isListening
                            ? Colors.white
                            : (_isSuccess ? Colors.green : AppColors.primary),
                        boxShadow: [
                          BoxShadow(
                            color:
                                (_isListening
                                        ? AppColors.gray400
                                        : (_isSuccess
                                              ? Colors.green
                                              : AppColors.primary))
                                    .withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Center(
                        child: _isListening
                            // Listening Anim
                            ? Lottie.asset(AssetPaths.listeningAnim, width: 80)
                            : (_isSuccess
                                  // Success Check
                                  ? const Icon(
                                      Icons.check,
                                      size: 60,
                                      color: Colors.white,
                                    ).animate().scale()
                                  // Default Mic
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
              ).animate().scale(curve: Curves.easeOutBack, duration: 500.ms),

              const Spacer(),

              // Footer Buttons
              Column(
                children: [
                  // Continue Button (Visible on Success)
                  if (_isSuccess)
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          ref.read(onboardingProvider.notifier).nextPage();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'AAGE BADHEIN',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ).animate().slideY(
                      begin: 1,
                      end: 0,
                      curve: Curves.easeOutBack,
                    ),

                  const SizedBox(height: AppSpacing.md),

                  // Skip Button (Hidden on Success)
                  if (!_isSuccess)
                    TextButton(
                      onPressed: () {
                        ref.read(onboardingProvider.notifier).nextPage();
                      },
                      child: Text(
                        'Baad mein try karunga',
                        style: TextStyle(
                          color: AppColors.textSecondaryLight,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ).animate().fadeIn(delay: 1.seconds),
                ],
              ),

              const SizedBox(height: AppSpacing.lg),

              // Progress Dots (4 of 7)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(7, (index) {
                  final isActive = index == 3; // 4th Screen
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: isActive ? 24 : 8,
                    decoration: BoxDecoration(
                      color: isActive ? AppColors.primary : AppColors.gray300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
          ),
        ),
      ),
    );
  }
}
