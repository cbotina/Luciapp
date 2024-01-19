import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/themes/presentation/controllers/theme_controller.dart';

class DarkModeIconButton extends ConsumerWidget {
  const DarkModeIconButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkModeEnabled =
        ref.watch(themeControllerProvider).value!.isDarkModeEnabled;

    return IconButton(
      icon: Icon(isDarkModeEnabled ? Icons.sunny : Icons.nightlight_round),
      onPressed: ref.read(themeControllerProvider.notifier).toggleDarkMode,
    );
  }
}
