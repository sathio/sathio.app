import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';

import 'screens/welcome_screen.dart';
import 'screens/language_screen.dart';
import 'screens/use_case_screen.dart'; // Updated import
import 'screens/voice_demo_screen.dart';
import 'screens/permission_screen.dart';
import 'screens/quick_win_screen.dart';
import 'screens/profile_setup_screen.dart';
import 'onboarding_provider.dart';

class OnboardingFlow extends ConsumerStatefulWidget {
  const OnboardingFlow({super.key});

  @override
  ConsumerState<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends ConsumerState<OnboardingFlow> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    // Initialize controller with current state from provider
    // Using ref.read in initState is safe for retrieving initial values
    final initialIndex = ref.read(onboardingProvider).currentIndex;
    _pageController = PageController(initialPage: initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final onboardingState = ref.watch(onboardingProvider);

    // Listen to state changes to animate page
    ref.listen(onboardingProvider, (previous, next) {
      if (previous?.currentIndex != next.currentIndex) {
        _pageController.animateToPage(
          next.currentIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });

    final screens = const [
      WelcomeScreen(),
      LanguageScreen(),
      UseCaseScreen(), // Replaced PurposeScreen
      VoiceDemoScreen(),
      PermissionScreen(),
      QuickWinScreen(),
      ProfileSetupScreen(),
    ];

    double progress = (onboardingState.currentIndex + 1) / screens.length;

    return Scaffold(
      body: Column(
        children: [
          // Progress Bar (Skip for Welcome Screen)
          if (onboardingState.currentIndex > 0)
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.textSecondaryLight,
                      ),
                      onPressed: () =>
                          ref.read(onboardingProvider.notifier).previousPage(),
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: AppColors.gray200,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.primary,
                          ),
                          minHeight: 8,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48), // Balance spacing
                  ],
                ),
              ),
            ),

          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(), // Disable swipe
              children: screens,
            ),
          ),
        ],
      ),
    );
  }
}
