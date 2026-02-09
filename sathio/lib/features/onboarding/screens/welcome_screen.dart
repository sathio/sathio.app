import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart'; // Add Lottie import
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/constants/asset_paths.dart'; // Add this
import '../onboarding_provider.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9), // Off-white background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.xl,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Animated Mascot
              SizedBox(
                    height: 250,
                    child: Lottie.asset(
                      AssetPaths.listeningAnim, // Mascot placeholder
                      fit: BoxFit.contain,
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .scale(duration: 600.ms, curve: Curves.easeOutBack),

              const SizedBox(height: AppSpacing.xxl),

              // Greeting Text
              Text(
                    'Namaste! 🙏',
                    style: context.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimaryLight,
                      letterSpacing: -0.5,
                    ),
                    textAlign: TextAlign.center,
                  )
                  .animate()
                  .fadeIn(delay: 200.ms)
                  .slideY(begin: 0.3, end: 0, curve: Curves.easeOut),

              const SizedBox(height: AppSpacing.sm),

              // Subtitle
              Text(
                    'Main Sathio hoon,\naapka digital saathi',
                    style: context.textTheme.headlineSmall?.copyWith(
                      color: AppColors.textSecondaryLight,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                  )
                  .animate()
                  .fadeIn(delay: 400.ms)
                  .slideY(begin: 0.3, end: 0, curve: Curves.easeOut),

              const Spacer(),

              // Primary Button
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
                        shadowColor: AppColors.primary.withOpacity(0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Shuru karein',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  )
                  .animate()
                  .fadeIn(delay: 600.ms)
                  .slideY(begin: 1, end: 0, curve: Curves.elasticOut),

              const SizedBox(height: AppSpacing.xl),

              // Progress Dots "1 of 7"
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(7, (index) {
                  // Only index 0 is active for Welcome Screen
                  final isActive = index == 0;
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
              ).animate().fadeIn(delay: 800.ms),

              const SizedBox(height: AppSpacing.sm),
            ],
          ),
        ),
      ),
    );
  }
}
