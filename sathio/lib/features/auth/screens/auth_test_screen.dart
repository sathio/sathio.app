import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../services/auth/auth_provider.dart';
import '../../../../services/auth/auth_state.dart';

class AuthTestScreen extends ConsumerStatefulWidget {
  const AuthTestScreen({super.key});

  @override
  ConsumerState<AuthTestScreen> createState() => _AuthTestScreenState();
}

class _AuthTestScreenState extends ConsumerState<AuthTestScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final authNotif = ref.read(authProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Auth Test')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Status Display
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.grey.shade200,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Status: ${authState.status.name}'),
                  if (authState.user != null) ...[
                    Text('User ID: ${authState.user!.id}'),
                    Text('Phone: ${authState.user!.phone ?? "N/A"}'),
                  ],
                  if (authState.errorMessage != null)
                    Text(
                      'Error: ${authState.errorMessage}',
                      style: const TextStyle(color: Colors.red),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            if (authState.status == AuthStatus.loading)
              const CircularProgressIndicator()
            else
              Expanded(
                child: ListView(
                  children: [
                    // Anonymous
                    ElevatedButton(
                      onPressed: () => authNotif.signInAnonymously(),
                      child: const Text('Sign In Anonymously'),
                    ),
                    const Divider(),

                    // Phone Auth
                    TextField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number (e.g. +91...)',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_phoneController.text.isNotEmpty) {
                          authNotif.signInWithPhone(
                            _phoneController.text.trim(),
                          );
                        }
                      },
                      child: const Text('Send OTP'),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _otpController,
                      decoration: const InputDecoration(labelText: 'OTP'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_phoneController.text.isNotEmpty &&
                            _otpController.text.isNotEmpty) {
                          authNotif.verifyOtp(
                            _phoneController.text.trim(),
                            _otpController.text.trim(),
                          );
                        }
                      },
                      child: const Text('Verify OTP'),
                    ),
                    const Divider(),

                    // Sign Out
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade100,
                      ),
                      onPressed: () => authNotif.signOut(),
                      child: const Text('Sign Out'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}