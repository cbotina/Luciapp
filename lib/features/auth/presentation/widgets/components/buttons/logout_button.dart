import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/common/keys/widget_keys.dart';
import 'package:luciapp/features/auth/presentation/controllers/auth_controller.dart';

class LogoutButton extends ConsumerWidget {
  const LogoutButton({super.key = Keys.logoutButton});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.logout),
      onPressed: ref.read(authControllerProvider.notifier).logOut,
    );
  }
}
