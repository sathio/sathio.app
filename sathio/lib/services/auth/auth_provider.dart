import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../shared/models/user_model.dart';
import 'auth_service.dart';
import 'auth_state.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authStateProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

class AuthNotifier extends Notifier<AuthState> {
  late final AuthService _authService;

  @override
  AuthState build() {
    _authService = ref.watch(authServiceProvider);
    _checkCurrentUser();
    return const AuthInitial();
  }

  Future<void> _checkCurrentUser() async {
    final user = _authService.currentUser;
    if (user != null) {
      state = AuthAuthenticated(_mapSupabaseUserToModel(user));
    } else {
      state = const AuthUnauthenticated();
    }
  }

  // Example mapping - in real app fetch from 'users' table or metadata
  UserModel _mapSupabaseUserToModel(supabase.User user) {
    return UserModel(
      id: user.id,
      phone: user.phone,
      name: user.userMetadata?['name'],
      language: user.userMetadata?['language'],
      createdAt: DateTime.parse(user.createdAt),
    );
  }

  Future<void> signInAnonymously() async {
    state = const AuthLoading();
    try {
      final response = await _authService.signInAnonymously();
      if (response.user != null) {
        state = AuthAuthenticated(_mapSupabaseUserToModel(response.user!));
      } else {
        state = const AuthError("Sign in failed");
      }
    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  Future<void> sendOtp(String phone) async {
    state = const AuthLoading();
    try {
      await _authService.signInWithPhone(phone);
      // State remains Loading or moves to 'OtpSent' if we had that state
      // For now, effectively waiting for verifyOtp
      state =
          const AuthUnauthenticated(); // Reset to allow UI to show OTP input
    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  Future<void> verifyOtp(String phone, String otp) async {
    state = const AuthLoading();
    try {
      final response = await _authService.verifyOtp(phone, otp);
      if (response.user != null) {
        state = AuthAuthenticated(_mapSupabaseUserToModel(response.user!));
      } else {
        state = const AuthError("Verification failed");
      }
    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  Future<void> signOut() async {
    state = const AuthLoading();
    try {
      await _authService.signOut();
      state = const AuthUnauthenticated();
    } catch (e) {
      state = AuthError(e.toString());
    }
  }
}
