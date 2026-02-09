import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/utils/extensions.dart';
import '../onboarding_provider.dart';

class UseCaseScreen extends ConsumerWidget {
  const UseCaseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingState = ref.watch(onboardingProvider);

    final useCases = [
      {
        'id': 'govt',
        'icon': '📄',
        'label': 'Sarkari kaam',
        'sub': 'Aadhaar, PAN, Ration',
      },
      {
        'id': 'bills',
        'icon': '💡',
        'label': 'Bill Payment',
        'sub': 'Bijli, Mobile, Gas',
      },
      {
        'id': 'health',
        'icon': '💊',
        'label': 'Health jaankari',
        'sub': 'Doctors, Schemes',
      },
      {
        'id': 'edu',
        'icon': '📚',
        'label': 'Padhai mein madad',
        'sub': 'Scholarships, Jobs',
      },
      {
        'id': 'finance',
        'icon': '💰',
        'label': 'Loan/Banking',
        'sub': 'Bank account, Loans',
      },
      {'id': 'other', 'icon': '❓', 'label': 'Kuch aur', 'sub': 'General help'},
    ];

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.xl),

            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Text(
                'Aap Sathio se kya karna chahte ho?',
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryLight,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn().slideY(begin: -0.2, end: 0),
            ),

            const SizedBox(height: AppSpacing.md),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Text(
                '(Select all that apply)',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondaryLight,
                ),
              ).animate().fadeIn(delay: 200.ms),
            ),

            const SizedBox(height: AppSpacing.lg),

            // Use Case Grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12, // Tighter spacing
                  childAspectRatio: 1.1, // Wider cards
                ),
                itemCount: useCases.length,
                itemBuilder: (context, index) {
                  final useCase = useCases[index];
                  final isSelected = onboardingState.selectedUseCases.contains(
                    useCase['id'],
                  );

                  return GestureDetector(
                        onTap: () {
                          ref
                              .read(onboardingProvider.notifier)
                              .toggleUseCase(useCase['id']!);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary.withValues(alpha: 0.1)
                                : Colors.white,
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.gray200,
                              width: isSelected ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              if (isSelected)
                                BoxShadow(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.2,
                                  ),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                useCase['icon']!,
                                style: const TextStyle(fontSize: 32),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                useCase['label']!,
                                style: context.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: AppColors.textPrimaryLight,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                useCase['sub']!,
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondaryLight,
                                  fontSize: 11,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      )
                      .animate()
                      .fadeIn(delay: (100 * index).ms)
                      .slideY(begin: 0.2, end: 0);
                },
              ),
            ),

            // Personalization Message (if 1+ selected)
            if (onboardingState.selectedUseCases.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Text(
                  "Main aapke liye ready ho jaunga! 🚀",
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ).animate().fadeIn().slideY(begin: 0.5, end: 0),
              ),

            const SizedBox(height: AppSpacing.md),

            // Continue Button (Always visible but disabled if empty, or only visible if selected? Requirement says "Continue button")
            // Requirement doesn't strictly say logic, but distinct from "appears on selection".
            // Let's make it appear or enable on selection for better UX.
            Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: onboardingState.selectedUseCases.isNotEmpty
                          ? () {
                              ref.read(onboardingProvider.notifier).nextPage();
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        disabledBackgroundColor: AppColors.gray300,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
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
                  ),
                )
                .animate(
                  target: onboardingState.selectedUseCases.isNotEmpty ? 1 : 0,
                )
                .fadeIn(),

            // Progress Dots (3 of 7)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(7, (index) {
                  final isActive = index == 2; // 3rd Screen
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
            ),
          ],
        ),
      ),
    );
  }
}
