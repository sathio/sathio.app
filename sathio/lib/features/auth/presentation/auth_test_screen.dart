import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/auth/auth_provider.dart';
import '../../../services/auth/auth_state.dart';

class AuthTestScreen extends ConsumerStatefulWidget {
  const AuthTestScreen({super.key});

  @override
  ConsumerState<AuthTestScreen> createState() => _AuthTestScreenState();
}

class _AuthTestScreenState extends ConsumerState<AuthTestScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final authNotifier = ref.read(authStateProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Auth Test')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Status Display
            Text('Status: $authState'),
            if (authState is AuthAuthenticated) ...[
              Text('User ID: ${authState.user.id}'),
              Text('Phone: ${authState.user.phone ?? "N/A"}'),
            ],
            if (authState is AuthError)
              Text(
                'Error: ${authState.message}',
                style: const TextStyle(color: Colors.red),
              ),

            const SizedBox(height: 20),

            // Anonymous Sign In
            ElevatedButton(
              onPressed: () => authNotifier.signInAnonymously(),
              child: const Text('Sign In Anonymously'),
            ),

            const Divider(),

            // Phone Auth
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number (e.g. +919000000000)',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_phoneController.text.isNotEmpty) {
                  authNotifier.sendOtp(_phoneController.text);
                }
              },
              child: const Text('Send OTP'),
            ),

            TextField(
              controller: _otpController,
              decoration: const InputDecoration(labelText: 'OTP'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_phoneController.text.isNotEmpty &&
                    _otpController.text.isNotEmpty) {
                  authNotifier.verifyOtp(
                    _phoneController.text,
                    _otpController.text,
                  );
                }
              },
              child: const Text('Verify OTP'),
            ),

            const Divider(),

            // Sign Out
            ElevatedButton(
              onPressed: () => authNotifier.signOut(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
