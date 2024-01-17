import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/themes/application/theme_service.dart';
import 'package:luciapp/features/themes/domain/enums/theme_mode.dart';

class ThemeController extends AsyncNotifier<AppThemeMode> {
  late final ThemeService _themeService = ref.watch(themeServiceProvider);

  @override
  FutureOr<AppThemeMode> build() {
    return _themeService.getCurrentTheme();
  }

  // Future<void> _setCurrentTheme() async {
  //   state = await AsyncValue.guard(() => _themeService.getCurrentTheme());
  // }

  Future<void> toggleDarkMode() async {
    state = await AsyncValue.guard(() => _themeService.toggleDarkMode());
  }

  Future<void> toggleHCMode() async {
    state = await AsyncValue.guard(() => _themeService.toggleHCMode());
  }
}

final themeControllerProvider =
    AsyncNotifierProvider<ThemeController, AppThemeMode>(
  () {
    return ThemeController();
  },
);
