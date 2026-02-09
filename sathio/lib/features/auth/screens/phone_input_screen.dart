import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/utils/extensions.dart';
import '../../../services/auth/auth_provider.dart';
import '../widgets/phone_input_field.dart';

class PhoneInputScreen extends ConsumerStatefulWidget {
  const PhoneInputScreen({super.key});

  @override
  ConsumerState<PhoneInputScreen> createState() => _PhoneInputScreenState();
}

class _PhoneInputScreenState extends ConsumerState<PhoneInputScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isValid = false;

  void _onPhoneChanged(String value) {
    // Simple validation: 10 digits (ignoring dashes)
    final digits = value.replaceAll(RegExp(r'\D'), '');
    setState(() {
      _isValid = digits.length == 10;
    });
  }

  void _onContinue() async {
    final phone = '+91${_phoneController.text.replaceAll(RegExp(r'\D'), '')}';
    // Trigger OTP send via provider
    await ref.read(authStateProvider.notifier).sendOtp(phone);
    // Navigate to OTP screen
    if (mounted) {
      context.push('/auth/otp', extra: phone);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.xl),
              // Logo or Header
              // Image.asset(AssetPaths.logo, height: 64),
              const SizedBox(height: AppSpacing.xl),

              Text(
                'Enter your mobile number',
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryLight,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'We will send you a verification code',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondaryLight,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppSpacing.xxl),

              PhoneInputField(
                controller: _phoneController,
                onChanged: _onPhoneChanged,
              ),

              const Spacer(),

              // Continue Button
              ElevatedButton(
                onPressed: _isValid ? _onContinue : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  disabledBackgroundColor: AppColors.gray300,
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                ),
                child: Text(
                  'Continue',
                  style: context.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              // Guest Link
              TextButton(
                onPressed: () {
                  ref.read(authStateProvider.notifier).signInAnonymously();
                },
                child: Text(
                  'Continue as Guest',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              // Privacy Text
              Text(
                'Aapka number safe hai',
                style: context.textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondaryLight,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
