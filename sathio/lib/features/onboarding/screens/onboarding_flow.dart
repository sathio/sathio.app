import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/utils/extensions.dart';
// import 'onboarding_screen.dart'; // Step 1: Welcome replaced by WelcomeScreen
// Steps 2 & 3 (Auth/OTP) will be handled via overlay or embedded?
// Logic: If we are in PageView, we can embed screens.
// For Auth, Luma uses bottom sheet.
// We will integrate Auth Test Screen logic or new screens here.
import 'phone_input_screen.dart'; // New local import
import 'language_selection_screen.dart';
import '../../home/screens/home_screen.dart';
import '../../../../services/auth/auth_provider.dart';
import '../../../../services/auth/auth_state.dart';
import '../providers/onboarding_provider.dart';
import 'welcome_screen.dart';
import 'auth_bottom_sheet.dart';
import 'profile_setup_screen.dart';

class OnboardingFlow extends ConsumerStatefulWidget {
  final VideoPlayerController? videoController;

  const OnboardingFlow({super.key, this.videoController});

  @override
  ConsumerState<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends ConsumerState<OnboardingFlow> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    widget.videoController?.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _next() {
    ref.read(onboardingProvider.notifier).nextPage();
    _pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _back() {
    final currentIndex = ref.read(onboardingProvider).currentIndex;
    if (currentIndex > 0) {
      int prevIndex = currentIndex - 1;

      // Custom Logic: Back from Language (2) -> Welcome (0)
      // Per user request, we skip showing Phone Input on back navigation from Language screen.
      if (currentIndex == 2) {
        prevIndex = 0;
      }

      ref.read(onboardingProvider.notifier).setPage(prevIndex);
      _pageController.animateToPage(
        prevIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      // Exit app or do nothing?
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingProvider);

    // Listen to Auth State for auto-advance
    ref.listen(authProvider, (previous, next) {
      if (next.status == AuthStatus.authenticated &&
          (previous?.status != AuthStatus.authenticated)) {
        // If user logs in (e.g. via OTP or Google), move to Language step (Index 2)
        // Flow: 0=Welcome, 1=Phone, 2=Language
        if (state.currentIndex < 2) {
          ref.read(onboardingProvider.notifier).setPage(2);
        }
      }
    });

    // Listen to state changes to sync page controller if needed (e.g. from skip)
    ref.listen(onboardingProvider, (previous, next) {
      if (previous?.currentIndex != next.currentIndex) {
        if (_pageController.hasClients &&
            _pageController.page?.round() != next.currentIndex) {
          _pageController.animateToPage(
            next.currentIndex,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        }
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          (state.currentIndex > 0 &&
              state.currentIndex != 3) // Hide for Profile (3) as it has its own
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: _back,
              ),
              actions: [
                // Skip logic for specific steps (e.g. Profile, Interests)
                if ([2, 3, 4].contains(state.currentIndex))
                  TextButton(
                    onPressed: _next,
                    child: Text(
                      'Skip',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ),
              ],
            )
          : null, // No AppBar on Welcome Screen
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // Disable swipe
        children: [
          // 0. Welcome - Opens Auth Sheet
          WelcomeScreen(
            videoController: widget.videoController,
            shouldPlay: state.currentIndex == 0,
            onGetStarted: () async {
              await showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                builder: (_) => AuthBottomSheet(
                  onPhoneTap: () {
                    Navigator.pop(context); // Close sheet
                    _pageController.animateToPage(
                      1, // Phone Input
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                    ref.read(onboardingProvider.notifier).setPage(1);
                  },
                  onGoogleTap: () {
                    Navigator.pop(context); // Close sheet
                    ref.read(authServiceProvider).signInWithGoogle();
                    // Listener will handle navigation on success
                  },
                  onGuestTap: () {
                    Navigator.pop(context); // Close sheet
                    // "Continue as Guest" behaves like "Skip" -> Go to Language (Index 2)
                    _pageController.animateToPage(
                      2, // Language Selection
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                    ref.read(onboardingProvider.notifier).setPage(2);
                  },
                ),
              );
            },
          ),

          // 1. Phone Input
          PhoneInputScreen(onSkip: _next),

          // 2. Language Selection
          LanguageSelectionScreen(onContinue: _next),

          // 3. Profile Setup
          // 3. Profile Setup
          ProfileSetupScreen(onContinue: _next, onBack: _back),

          // 4. Interest Selection
          _PlaceholderStep(title: 'Step 5: Interests', onNext: _next),

          // 5. Voice Demo
          _PlaceholderStep(title: 'Step 6: Voice Demo', onNext: _next),

          // 6. Permissions
          _PlaceholderStep(title: 'Step 7: Permissions', onNext: _next),

          // 7. Home (Navigates out of flow)
          _PlaceholderStep(
            title: 'Step 8: All Set!',
            onNext: () {
              ref.read(onboardingProvider.notifier).completeOnboarding();
              // Navigate to Home replacing Route
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              );
            },
            buttonText: 'Go Home',
          ),
        ],
      ),
    );
  }
}

class _PlaceholderStep extends StatelessWidget {
  final String title;
  final VoidCallback onNext;
  final String buttonText;

  const _PlaceholderStep({
    required this.title,
    required this.onNext,
    this.buttonText = 'Next',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: onNext, child: Text(buttonText)),
        ],
      ),
    );
  }
}
