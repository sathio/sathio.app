import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;
import 'auth_state.dart';

class AuthService {
  final SupabaseClient _supabase;

  AuthService(this._supabase);

  // --- Stream ---
  Stream<AuthState> get authStateChanges {
    return _supabase.auth.onAuthStateChange.map((data) {
      final session = data.session;
      if (session != null) {
        return AuthState(
          status: AuthStatus.authenticated,
          user: _mapSupabaseUser(session.user),
        );
      } else {
        return const AuthState(status: AuthStatus.unauthenticated);
      }
    });
  }

  // --- Actions ---

  Future<void> signInAnonymously() async {
    try {
      await _supabase.auth.signInAnonymously();
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> signInWithPhone(String phone) async {
    try {
      await _supabase.auth.signInWithOtp(
        phone: phone,
        // In debug/dev, Supabase often uses a fixed OTP (e.g., 123456) if configured
      );
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> verifyOtp(String phone, String token) async {
    try {
      await _supabase.auth.verifyOTP(
        phone: phone,
        token: token,
        type: OtpType.sms,
      );
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      // Web/Android implementation details vary.
      // For simplicity, using standard OAuth provider flow.
      await _supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'com.sathio.app://login-callback/',
      );
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      throw _handleError(e);
    }
  }

  UserModel? getCurrentUser() {
    final user = _supabase.auth.currentUser;
    if (user != null) {
      return _mapSupabaseUser(user);
    }
    return null;
  }

  bool isAuthenticated() {
    return _supabase.auth.currentSession != null;
  }

  // --- Helpers ---

  UserModel _mapSupabaseUser(User user) {
    return UserModel(
      id: user.id,
      phone: user.phone,
      email: user.email,
      name: user.userMetadata?['name'] as String?,
      createdAt: DateTime.parse(user.createdAt),
    );
  }

  Exception _handleError(dynamic error) {
    if (error is AuthException) {
      return Exception(error.message);
    }
    return Exception('An unexpected error occurred: $error');
  }
}
