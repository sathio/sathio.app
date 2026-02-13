import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import '../../../../core/utils/extensions.dart';
import '../../../../services/auth/auth_provider.dart';
import '../../../../services/auth/auth_state.dart';
import '../widgets/otp_input.dart';

class OtpVerificationScreen extends ConsumerStatefulWidget {
  final String phoneNumber;

  const OtpVerificationScreen({super.key, required this.phoneNumber});

  @override
  ConsumerState<OtpVerificationScreen> createState() =>
      _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends ConsumerState<OtpVerificationScreen> {
  int _secondsRemaining = 60;
  Timer? _timer;
  bool _canResend = false;

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
        _timer?.cancel();
      }
    });
  }

  void _onResend() {
    if (!_canResend) return;
    ref.read(authProvider.notifier).signInWithPhone(widget.phoneNumber);
    _startTimer();
  }

  void _onOtpCompleted(String otp) async {
    await ref.read(authProvider.notifier).verifyOtp(widget.phoneNumber, otp);

    if (mounted) {
      final authState = ref.read(authProvider);
      if (authState.errorMessage != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(authState.errorMessage!)));
      } else {
        // Success! Pop to reveal OnboardingFlow which acts on auth state
        if (mounted && context.canPop()) {
          context.pop();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authProvider).status == AuthStatus.loading;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'Verify Phone Number',
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Enter the code sent to ${widget.phoneNumber}',
              style: context.textTheme.bodyLarge?.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 40),

            // OTP Input
            Center(child: OtpInput(onCompleted: _onOtpCompleted)),

            const SizedBox(height: 40),

            // Loading or Timer
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else
              Center(
                child: _canResend
                    ? TextButton(
                        onPressed: _onResend,
                        child: Text(
                          'Resend OTP',
                          style: TextStyle(
                            color: context.theme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Text(
                        'Resend code in 00:${_secondsRemaining.toString().padLeft(2, '0')}',
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
              ),
          ],
        ),
      ),
    );
  }
}
