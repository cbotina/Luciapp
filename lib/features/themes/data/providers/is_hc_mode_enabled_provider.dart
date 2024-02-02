import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/themes/presentation/controllers/theme_controller.dart';

final isHcModeEnabledProvider = Provider<bool>((ref) {
  return ref.watch(themeControllerProvider).value!.isHCModeEnabled;
});
