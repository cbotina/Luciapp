import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/themes/data/providers/is_dark_mode_enabled_provider.dart';
import 'package:luciapp/features/themes/presentation/controllers/theme_controller.dart';
import 'package:luciapp/features/themes/presentation/widgets/constants/widget_keys.dart';

class DarkModeIconButton extends ConsumerWidget {
  const DarkModeIconButton({super.key = Keys.darkModeIconButton});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkModeEnabled = ref.watch(isDarkModeEnabledProvider);

    return Semantics(
      label: '${isDarkModeEnabled ? 'Desactivar' : 'Activar'} modo oscuro',
      child: ExcludeSemantics(
        child: IconButton(
          icon: Icon(isDarkModeEnabled ? Icons.sunny : Icons.nightlight_round),
          onPressed: ref.read(themeControllerProvider.notifier).toggleDarkMode,
        ),
      ),
    );
  }
}
