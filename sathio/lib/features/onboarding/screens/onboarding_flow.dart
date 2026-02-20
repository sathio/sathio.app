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
import 'interest_screen.dart'; // New local import
import 'language_selection_screen.dart';
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
  final GlobalKey<State<PhoneInputScreen>> _phoneInputKey = GlobalKey();

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
    // Always unfocus keyboard when going back
    FocusScope.of(context).unfocus();

    final currentIndex = ref.read(onboardingProvider).currentIndex;
    if (currentIndex > 0) {
      int prevIndex = currentIndex - 1;
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
    final onboardingState = ref.watch(onboardingProvider);

    // Listen to Auth State for auto-advance
    ref.listen(authProvider, (previous, next) {
      if (next.status == AuthStatus.authenticated &&
          (previous?.status != AuthStatus.authenticated)) {
        // If user logs in (e.g. via OTP or Google), move to Language step (Index 2)
        // Flow: 0=Welcome, 1=Phone, 2=Language
        if (onboardingState.currentIndex < 2) {
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

    return PopScope(
      canPop: onboardingState.currentIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _back();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: (onboardingState.currentIndex > 0)
            ? AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: _back,
                ),
                actions: [
                  // Skip logic for specific steps (e.g. Profile, Interests)
                  if ([2, 3, 4].contains(onboardingState.currentIndex))
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
              shouldPlay: onboardingState.currentIndex == 0,
              onGetStarted: () async {
                // Track which action was taken inside the sheet
                String? action;
                await showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  builder: (_) => AuthBottomSheet(
                    onPhoneTap: () {
                      action = 'phone';
                      Navigator.pop(context); // Close sheet
                    },
                    onGoogleTap: () {
                      action = 'google';
                      Navigator.pop(context); // Close sheet
                    },
                    onGuestTap: () {
                      action = 'guest';
                      Navigator.pop(context); // Close sheet
                    },
                  ),
                );

                // Sheet is now fully closed — dismiss any rogue focus first
                if (mounted) {
                  FocusManager.instance.primaryFocus?.unfocus();
                }

                // Now perform the action
                if (action == 'phone') {
                  ref.read(onboardingProvider.notifier).setGuest(false);
                  _pageController.animateToPage(
                    1, // Phone Input
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                  ref.read(onboardingProvider.notifier).setPage(1);
                  // Request focus after page animation starts
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    final state = _phoneInputKey.currentState;
                    if (state != null) {
                      (state as dynamic).requestFocus();
                    }
                  });
                } else if (action == 'google') {
                  ref.read(authServiceProvider).signInWithGoogle();
                } else if (action == 'guest') {
                  // Set guest mode
                  ref.read(onboardingProvider.notifier).setGuest(true);

                  // Force close keyboard
                  if (context.mounted) {
                    FocusScope.of(context).unfocus();
                  }

                  // Small delay to ensure state update propagates
                  Future.delayed(const Duration(milliseconds: 50), () {
                    if (mounted) {
                      // Navigate to Language (Index 1 in Guest Mode)
                      _pageController.animateToPage(
                        1,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                      ref.read(onboardingProvider.notifier).setPage(1);
                    }
                  });
                }
                // action == null means user dismissed via X or swipe — stay on Welcome
              },
            ),

            // 1. Phone Input (Only if NOT guest)
            if (!onboardingState.isGuest)
              PhoneInputScreen(key: _phoneInputKey, onSkip: _next),

            // 2. Language Selection
            LanguageSelectionScreen(onContinue: _next),

            // 3. Profile Setup
            ProfileSetupScreen(onContinue: _next, onBack: _back),

            // 4. Interest Selection (Final Step - navigates to Home)
            const InterestScreen(),
          ],
        ),
      ),
    );
  }
}
