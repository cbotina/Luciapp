import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/presentation/controllers/auth_controller.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
              onPressed:
                  ref.read(authControllerProvider.notifier).loginWithGoogle,
              child: const Text("Login with Google")),
          ElevatedButton(
              onPressed:
                  ref.read(authControllerProvider.notifier).loginWithFacebook,
              child: const Text("Login with Facebook")),
        ],
      ),
    );
  }
}
