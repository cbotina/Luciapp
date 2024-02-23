import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/themes/data/providers/is_dark_mode_enabled_provider.dart';
import 'package:luciapp/features/themes/data/providers/is_hc_mode_enabled_provider.dart';
import 'package:luciapp/features/themes/domain/enums/app_theme_mode.dart';
import 'package:luciapp/features/themes/presentation/state/theme_state.dart';

final themeModeProvider = Provider<AppThemeMode>((ref) {
  final dark = ref.watch(isDarkModeEnabledProvider);
  final hc = ref.watch(isHcModeEnabledProvider);
  return ThemeState(isDarkModeEnabled: dark, isHCModeEnabled: hc).appThemeMode;
});
