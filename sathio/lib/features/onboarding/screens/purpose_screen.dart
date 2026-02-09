import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/utils/extensions.dart';
import '../onboarding_provider.dart';

class PurposeScreen extends ConsumerWidget {
  const PurposeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingState = ref.watch(onboardingProvider);
    final purposes = [
      {'label': 'Learn new skills', 'icon': Icons.school},
      {'label': 'Prepare for job', 'icon': Icons.work},
      {'label': 'Daily tasks help', 'icon': Icons.task_alt},
      {'label': 'Just exploring', 'icon': Icons.explore},
    ];

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.xl),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Text(
                'I am here to...',
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryLight,
                ),
              ).animate().fadeIn().slideY(begin: -0.2, end: 0),
            ),
            const SizedBox(height: AppSpacing.lg),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                itemCount: purposes.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final purpose = purposes[index];
                  final isSelected =
                      onboardingState.selectedPurpose == purpose['label'];

                  return GestureDetector(
                        onTap: () => ref
                            .read(onboardingProvider.notifier)
                            .selectPurpose(purpose['label'] as String),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary.withValues(alpha: 0.1)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.gray200,
                              width: isSelected ? 2.5 : 1.5,
                            ),
                            boxShadow: [
                              if (!isSelected)
                                BoxShadow(
                                  color: AppColors.gray200,
                                  offset: const Offset(0, 4),
                                  blurRadius: 0,
                                ),
                              if (isSelected)
                                BoxShadow(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.4,
                                  ),
                                  offset: const Offset(0, 0),
                                  blurRadius: 0,
                                ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                purpose['icon'] as IconData,
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.gray500,
                                size: 28,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  purpose['label'] as String,
                                  style: context.textTheme.titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: isSelected
                                            ? AppColors.primary
                                            : AppColors.textPrimaryLight,
                                      ),
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: AppColors.primary,
                                ).animate().scale(),
                            ],
                          ),
                        ),
                      )
                      .animate()
                      .fadeIn(delay: (100 * index).ms)
                      .slideX(begin: 0.2, end: 0);
                },
              ),
            ),

            // Continue Button (Animated entry)
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: onboardingState.selectedPurpose != null
                      ? () => ref.read(onboardingProvider.notifier).nextPage()
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    disabledBackgroundColor: AppColors.gray300,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'CONTINUE',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
            ).animate().slideY(begin: 1, end: 0, delay: 500.ms),
          ],
        ),
      ),
    );
  }
}
