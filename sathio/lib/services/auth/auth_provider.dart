import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/supabase/supabase_service.dart';
import 'auth_service.dart';
import 'auth_state.dart';

// Service Provider
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(SupabaseService().client);
});

// State Provider
final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    final authService = ref.watch(authServiceProvider);
    _init(authService);
    return const AuthState();
  }

  AuthService get _authService => ref.read(authServiceProvider);

  void _init(AuthService authService) {
    // Listen to stream of auth changes from Supabase
    authService.authStateChanges.listen((authState) {
      state = authState;
    });
  }

  Future<void> signInAnonymously() async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      await _authService.signInAnonymously();
      // Stream will update state to authenticated
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> signInWithPhone(String phone) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      await _authService.signInWithPhone(phone);
      // Status remains loading or moves to 'otp_sent' if we had that status
      // valid for UI to show "OTP Sent" message
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> verifyOtp(String phone, String otp) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      await _authService.verifyOtp(phone, otp);
      // Stream will update state
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> signOut() async {
    try {
      await _authService.signOut();
      // Stream will update state
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      );
    }
  }
}
