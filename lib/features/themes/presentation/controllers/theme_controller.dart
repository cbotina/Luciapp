import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/data/providers/user_id_provider.dart';
import 'package:luciapp/features/themes/application/theme_service.dart';
import 'package:luciapp/features/themes/presentation/state/theme_state.dart';

class ThemeController extends AsyncNotifier<ThemeState> {
  late final ThemeService _themeService = ref.watch(themeServiceProvider);

  @override
  FutureOr<ThemeState> build() {
    return _themeService.getCurrentThemeState();
  }

  Future<void> refresh() async {
    ref.watch(userIdProvider);
    state = await AsyncValue.guard(() => _themeService.getCurrentThemeState());
  }

  Future<void> toggleDarkMode() async {
    state = await AsyncValue.guard(() => _themeService.toggleDarkMode());
  }

  Future<void> toggleHCMode() async {
    state = await AsyncValue.guard(() => _themeService.toggleHCMode());
  }
}

final themeControllerProvider =
    AsyncNotifierProvider<ThemeController, ThemeState>(
  () {
    return ThemeController();
  },
);
