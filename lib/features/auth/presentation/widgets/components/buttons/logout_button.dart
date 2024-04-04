import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/presentation/widgets/constants/strings.dart';
import 'package:luciapp/features/auth/presentation/controllers/auth_controller.dart';
import 'package:luciapp/features/auth/presentation/widgets/constants/widget_keys.dart';
import 'package:luciapp/features/themes/presentation/controllers/theme_controller.dart';

class LogoutButton extends ConsumerWidget {
  const LogoutButton({super.key = Keys.logoutButton});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () {
        ref.read(authControllerProvider.notifier).logout();
        ref.read(themeControllerProvider.notifier).refresh();
      },
      child: const Text(Strings.exit),
    );
  }
}
