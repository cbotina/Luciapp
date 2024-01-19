import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/themes/presentation/controllers/theme_controller.dart';

class AppLogotype extends ConsumerWidget {
  const AppLogotype({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTheme = ref.watch(themeControllerProvider);

    return activeTheme.when(
      data: (data) {
        final imagePath =
            'assets/images/${data.appThemeMode.toString()}/imagotype.png';
        return Image.asset(
          imagePath,
          height: 30,
          fit: BoxFit.fitHeight,
        );
      },
      error: (error, stackTrace) {
        return const Text("Error loading the image");
      },
      loading: () => const CircularProgressIndicator(),
    );
  }
}
