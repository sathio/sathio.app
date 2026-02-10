import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../services/supabase/supabase_service.dart';
import '../onboarding_provider.dart';

enum AuthView { options, phoneInput, otpInput }

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  AuthView _currentView = AuthView.options;
  bool _isLoading = false;

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    SupabaseService().client.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;

      if (event == AuthChangeEvent.signedIn && session != null) {
        _handleAuthSuccess(session.user);
      }
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _handleAuthSuccess(User user) {
    if (!mounted) return;

    // Extract name
    final fullName = user.userMetadata?['full_name'] as String?;
    final firstName = fullName?.split(' ').first;

    if (firstName != null && firstName.isNotEmpty) {
      ref.read(onboardingProvider.notifier).setUserName(firstName);
    } else {
      // Phone users have no name initially
      ref.read(onboardingProvider.notifier).setUserName(''); // Explicit empty
    }

    // Move to next page
    ref.read(onboardingProvider.notifier).nextPage();
  }

  Future<void> _googleSignIn() async {
    setState(() {
      _errorMessage = null;
      _isLoading = true;
    });
    try {
      await SupabaseService().client.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'io.supabase.flutter://login-callback/',
      );
    } catch (e) {
      if (mounted)
        setState(() => _errorMessage = 'Google Login Failed: ${e.toString()}');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _sendOtp() async {
    final phone = _phoneController.text.trim();
    if (phone.length < 10) {
      setState(() => _errorMessage = 'Please enter a valid phone number');
      return;
    }

    setState(() {
      _errorMessage = null;
      _isLoading = true;
    });

    try {
      // Assuming India (+91) for now based on context 'Sathio'
      // Ideally should have country picker
      final fullPhone = '+91$phone';
      await SupabaseService().client.auth.signInWithOtp(phone: fullPhone);

      if (mounted) {
        setState(() {
          _currentView = AuthView.otpInput;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage =
              'Failed to send OTP: ${e.toString()}'; // e.message if AuthException
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _verifyOtp() async {
    final otp = _otpController.text.trim();
    if (otp.length != 6) {
      setState(() => _errorMessage = 'Please enter a 6-digit code');
      return;
    }

    setState(() {
      _errorMessage = null;
      _isLoading = true;
    });

    try {
      final fullPhone = '+91${_phoneController.text.trim()}';
      final response = await SupabaseService().client.auth.verifyOTP(
        token: otp,
        type: OtpType.sms,
        phone: fullPhone,
      );

      if (response.session == null) {
        throw 'Verification failed';
      }
      // Auth listener handles success
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Invalid OTP: ${e.toString()}';
          _isLoading = false;
        });
      }
    }
  }

  void _onBack() {
    setState(() {
      _errorMessage = null;
      if (_currentView == AuthView.otpInput) {
        _currentView = AuthView.phoneInput;
      } else if (_currentView == AuthView.phoneInput) {
        _currentView = AuthView.options;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool showBack = _currentView != AuthView.options;

    return Scaffold(
      backgroundColor: AppColors.orange,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Expanded(
            flex: 3,
            child: SafeArea(
              bottom: false,
              child: Stack(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _currentView == AuthView.options
                                ? 'Login'
                                : 'Verify',
                            style: GoogleFonts.poppins(
                              fontSize: 48,
                              height: 1.0,
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFFFBF4E2),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _currentView == AuthView.options
                                ? 'Apna account banayein'
                                : (_currentView == AuthView.phoneInput
                                      ? 'Enter your mobile number'
                                      : 'Enter the code sent to +91 ${_phoneController.text}'),
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(0.9),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (showBack)
                    Positioned(
                      top: 16,
                      left: 16,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: _onBack,
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Body
          Expanded(
            flex: 7,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFFBF4E2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: AppColors.orange),
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        children: [
                          if (_errorMessage != null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Text(
                                _errorMessage!,
                                style: GoogleFonts.poppins(
                                  color: Colors.red,
                                  fontSize: 13,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),

                          if (_currentView == AuthView.options) ...[
                            _buildSocialButton(
                              label: 'Continue with Google',
                              icon: Icons.g_mobiledata,
                              color: Colors.white,
                              textColor: Colors.black87,
                              onTap: _googleSignIn,
                            ),
                            const SizedBox(height: 16),
                            _buildSocialButton(
                              label: 'Continue with Phone',
                              icon: Icons.phone_android,
                              color: Colors.white,
                              textColor: Colors.black87,
                              outline: true,
                              onTap: () => setState(
                                () => _currentView = AuthView.phoneInput,
                              ),
                            ),

                            const SizedBox(height: 24),

                            TextButton(
                              onPressed: () {
                                ref
                                    .read(onboardingProvider.notifier)
                                    .setUserName(''); // Guest has no name
                                ref
                                    .read(onboardingProvider.notifier)
                                    .nextPage();
                              },
                              child: Text(
                                'Continue as Guest',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ] else if (_currentView == AuthView.phoneInput) ...[
                            _buildPhoneInput(),
                            const SizedBox(height: 24),
                            _buildActionButton('Send OTP', _sendOtp),
                          ] else if (_currentView == AuthView.otpInput) ...[
                            _buildOtpInput(),
                            const SizedBox(height: 24),
                            _buildActionButton('Verify', _verifyOtp),
                            TextButton(
                              onPressed: _sendOtp, // Resend logic same as send
                              child: Text(
                                "Resend Code",
                                style: GoogleFonts.poppins(
                                  color: AppColors.orange,
                                ),
                              ),
                            ),
                          ],

                          const SizedBox(height: 32),
                          if (_currentView == AuthView.options)
                            Text(
                              'Secure & Private',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.black38,
                              ),
                            ),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Mobile Number",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black12),
          ),
          child: Row(
            children: [
              Text(
                "+91",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(width: 12),
              Container(width: 1, height: 24, color: Colors.black12),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '00000 00000',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOtpInput() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black12),
          ),
          child: TextField(
            controller: _otpController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 8,
            ),
            maxLength: 6,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: '000000',
              counterText: "",
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(String label, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.orange,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 4,
          shadowColor: AppColors.orange.withOpacity(0.4),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required String label,
    required IconData icon,
    required Color color,
    required Color textColor,
    required VoidCallback onTap,
    bool outline = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
          border: outline
              ? Border.all(color: AppColors.orange, width: 2)
              : null,
          boxShadow: [
            if (!outline)
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: outline ? AppColors.orange : textColor, size: 28),
            const SizedBox(width: 12),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: outline ? AppColors.orange : textColor,
              ),
            ),
          ],
        ),
      ),
    ).animate().scale(duration: 300.ms, curve: Curves.easeOutBack);
  }
}
