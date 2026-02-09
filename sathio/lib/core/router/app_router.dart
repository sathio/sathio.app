import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/home_screen.dart';
import '../../features/auth/presentation/auth_test_screen.dart';
import '../../features/auth/screens/phone_input_screen.dart';
import '../../features/auth/screens/otp_verification_screen.dart';
import '../../features/onboarding/onboarding_flow.dart';
import '../../features/onboarding/onboarding_provider.dart';
import '../../features/onboarding/screens/onboarding_complete_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  // Watch onboarding state to trigger rebuilds on change
  final onboardingState = ref.watch(onboardingProvider);

  return GoRouter(
    initialLocation: onboardingState.isCompleted ? '/' : '/onboarding',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/auth-test',
        builder: (context, state) => const AuthTestScreen(),
      ),
      GoRoute(
        path: '/auth/phone',
        builder: (context, state) => const PhoneInputScreen(),
      ),
      GoRoute(
        path: '/auth/otp',
        builder: (context, state) {
          final phone = state.extra as String;
          return OtpVerificationScreen(phone: phone);
        },
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingFlow(),
      ),
      GoRoute(
        path: '/onboarding-complete',
        builder: (context, state) => const OnboardingCompleteScreen(),
      ),
    ],
    redirect: (context, state) {
      final isCompleted = ref.read(onboardingProvider).isCompleted;
      final isOnboardingRoute = state.uri.path == '/onboarding';

      if (!isCompleted && !isOnboardingRoute) {
        return '/onboarding';
      }

      if (isCompleted && isOnboardingRoute) {
        return '/';
      }

      return null;
    },
  );
});
