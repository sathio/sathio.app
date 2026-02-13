import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../services/auth/auth_provider.dart';
import '../../../../services/auth/auth_state.dart';
import '../widgets/phone_input_field.dart';

class PhoneInputScreen extends ConsumerStatefulWidget {
  const PhoneInputScreen({super.key});

  @override
  ConsumerState<PhoneInputScreen> createState() => _PhoneInputScreenState();
}

class _PhoneInputScreenState extends ConsumerState<PhoneInputScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isValid = false;

  void _validatePhone(String value) {
    // Basic validation: Just check for 10 digits/length
    // The formatter adds hyphens, so length will be 12 (10 digits + 2 hyphens)
    // Or 10 if we check raw digits.
    final digits = value.replaceAll(RegExp(r'\D'), '');
    setState(() {
      _isValid = digits.length == 10;
    });
  }

  void _onContinue() async {
    if (!_isValid) return;
    final digits = _phoneController.text.replaceAll(RegExp(r'\D'), '');
    final phoneWithCode = '+91$digits';

    // Call provider to send OTP
    await ref.read(authProvider.notifier).signInWithPhone(phoneWithCode);

    // Check for errors or success
    if (mounted) {
      final authState = ref.read(authProvider);
      if (authState.errorMessage != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(authState.errorMessage!)));
      } else {
        // Navigate to OTP screen
        // Passing phone number as extra
        context.push('/auth/otp', extra: phoneWithCode);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authProvider).status == AuthStatus.loading;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              // Branding
              Text(
                'Sathio',
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.theme.primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter your phone number to continue',
                style: context.textTheme.bodyLarge?.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 40),

              // Input
              PhoneInputField(
                controller: _phoneController,
                onChanged: _validatePhone,
              ),
              const SizedBox(height: 40),

              // Action Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: (_isValid && !isLoading) ? _onContinue : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.theme.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: isLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          'Continue',
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
              const Spacer(),

              // Guest Link
              Center(
                child: TextButton(
                  onPressed: () {
                    // Handle Guest Login
                    ref.read(authProvider.notifier).signInAnonymously();
                  },
                  child: Text(
                    'Continue as Guest',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Privacy Note
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.lock_outline,
                      size: 16,
                      color: Colors.grey.shade500,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Aapka number safe hai',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
