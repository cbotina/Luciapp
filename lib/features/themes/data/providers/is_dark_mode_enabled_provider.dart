import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/themes/presentation/controllers/theme_controller.dart';

final isDarkModeEnabledProvider = Provider<bool>((ref) {
  return ref.watch(themeControllerProvider).value!.isDarkModeEnabled;
});
