import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/utils/extensions.dart';
import '../../../services/auth/auth_provider.dart';
import '../../../services/auth/auth_state.dart';
import '../widgets/otp_input.dart';

class OtpVerificationScreen extends ConsumerStatefulWidget {
  final String phone;

  const OtpVerificationScreen({super.key, required this.phone});

  @override
  ConsumerState<OtpVerificationScreen> createState() =>
      _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends ConsumerState<OtpVerificationScreen> {
  int _secondsRemaining = 60;
  Timer? _timer;
  bool _canResend = false;
  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _secondsRemaining = 60;
      _canResend = false;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _canResend = true;
        });
        timer.cancel();
      }
    });
  }

  void _onResend() {
    if (_canResend) {
      ref.read(authStateProvider.notifier).sendOtp(widget.phone);
      _startTimer();
    }
  }

  void _onOtpCompleted(String otp) async {
    setState(() {
      _isVerifying = true;
    });
    await ref.read(authStateProvider.notifier).verifyOtp(widget.phone, otp);
    if (mounted) {
      setState(() {
        _isVerifying = false;
      });
      // Navigation is handled by auth state listener in router or here check state
      final authState = ref.read(authStateProvider);
      if (authState is AuthAuthenticated) {
        context.go('/'); // Go to home on success
      } else if (authState is AuthError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authState.message),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimaryLight),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Verify Phone Number',
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Code sent to ${widget.phone}',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondaryLight,
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),

              OtpInput(onCompleted: _onOtpCompleted),

              const SizedBox(height: AppSpacing.xl),

              if (_isVerifying)
                const CircularProgressIndicator()
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't receive code? ",
                      style: context.textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: _canResend ? _onResend : null,
                      child: Text(
                        _canResend
                            ? 'Resend'
                            : 'Resend in ${_secondsRemaining}s',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: _canResend
                              ? AppColors.primary
                              : AppColors.gray500,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
