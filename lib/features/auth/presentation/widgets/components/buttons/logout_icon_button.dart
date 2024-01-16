import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/presentation/controllers/auth_controller.dart';
import 'package:luciapp/features/auth/presentation/widgets/constants/widget_keys.dart';

class LogoutIconButton extends ConsumerWidget {
  const LogoutIconButton({super.key = Keys.logoutIconButton});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.logout),
      onPressed: ref.read(authControllerProvider.notifier).logout,
    );
  }
}
