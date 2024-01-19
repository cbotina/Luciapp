import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/themes/presentation/controllers/theme_controller.dart';

class ImagotypeWithSlogan extends ConsumerWidget {
  final double heigth;
  const ImagotypeWithSlogan({
    required this.heigth,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTheme = ref.watch(themeControllerProvider);

    return activeTheme.when(
      data: (data) {
        final imagePath =
            'assets/images/${data.appThemeMode.toString()}/imagotype_slogan.png';
        return Image.asset(
          imagePath,
          height: heigth,
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
