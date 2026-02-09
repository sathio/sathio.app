import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _client = Supabase.instance.client;

  // Singleton
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  SupabaseClient get client => _client;
  Session? get currentSession => _client.auth.currentSession;
  User? get currentUser => _client.auth.currentUser;

  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;

  /// Sign in anonymously
  Future<AuthResponse> signInAnonymously() async {
    try {
      return await _client.auth.signInAnonymously();
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  /// Sign in with Phone (Sends OTP)
  Future<void> signInWithPhone(String phone) async {
    try {
      await _client.auth.signInWithOtp(phone: phone, shouldCreateUser: true);
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  /// Verify OTP
  Future<AuthResponse> verifyOtp(String phone, String otp) async {
    try {
      return await _client.auth.verifyOTP(
        type: OtpType.sms,
        token: otp,
        phone: phone,
      );
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  /// Sign in with Google (Web/Android flow)
  Future<bool> signInWithGoogle() async {
    try {
      // Note: This requires Google Sign-In setup in Supabase and Android
      return await _client.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'com.sathio.app://login-callback/',
      );
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  /// Sign Out
  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  /// Helper to handle Auth errors
  Exception _handleAuthError(dynamic error) {
    if (error is AuthException) {
      return Exception(error.message);
    }
    return Exception(error.toString());
  }
}
