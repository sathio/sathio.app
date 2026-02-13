import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../services/auth/auth_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sathio Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authProvider.notifier).signOut();
              // In a real app, you might navigate back to splash/onboarding
              // or let the auth stream listener handle routing.
              // For now, simple sign out.
            },
          ),
        ],
      ),
      body: const Center(child: Text('Welcome Home!')),
    );
  }
}
