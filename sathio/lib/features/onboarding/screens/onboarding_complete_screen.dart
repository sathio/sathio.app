import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/asset_paths.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/utils/extensions.dart';
import '../onboarding_provider.dart';

class OnboardingCompleteScreen extends ConsumerStatefulWidget {
  const OnboardingCompleteScreen({super.key});

  @override
  ConsumerState<OnboardingCompleteScreen> createState() =>
      _OnboardingCompleteScreenState();
}

class _OnboardingCompleteScreenState
    extends ConsumerState<OnboardingCompleteScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Auto-dismiss after 3 seconds
    _timer = Timer(const Duration(seconds: 3), _finishOnboarding);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _finishOnboarding() async {
    _timer?.cancel();
    await ref.read(onboardingProvider.notifier).completeOnboarding();
    if (mounted) {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: GestureDetector(
        onTap: _finishOnboarding, // Tap anywhere to skip
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: [
            // Centered Content
            Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Mascot (Logo) with Bounce Animation
                    Image.asset(AssetPaths.logo, height: 120)
                        .animate(onPlay: (c) => c.repeat(reverse: true))
                        .scale(
                          begin: const Offset(1.0, 1.0),
                          end: const Offset(1.1, 1.1),
                          duration: 1.seconds,
                          curve: Curves.easeInOut,
                        )
                        .then()
                        .shimmer(duration: 2.seconds),

                    const SizedBox(height: AppSpacing.xl),

                    // Title
                    Text(
                      'Badhai ho!\nAb aap ready ho! 🎉',
                      style: context.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimaryLight,
                      ),
                      textAlign: TextAlign.center,
                    ).animate().fadeIn().slideY(begin: 0.2, end: 0),

                    const SizedBox(height: AppSpacing.md),

                    // Subtitle
                    Text(
                      'Jab bhi madad chahiye,\nmain yahan hoon',
                      style: context.textTheme.titleMedium?.copyWith(
                        color: AppColors.textSecondaryLight,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ).animate().fadeIn(delay: 300.ms),
                  ],
                ),
              ),
            ),

            // Confetti Overlay
            Positioned.fill(
              child: IgnorePointer(
                child: Lottie.asset(
                  AssetPaths.successAnim,
                  repeat: false,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Tap hint at bottom
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Tap anywhere to start',
                  style: TextStyle(
                    color: AppColors.textSecondaryLight.withOpacity(0.5),
                    fontSize: 12,
                  ),
                ).animate().fadeIn(delay: 2.seconds),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
