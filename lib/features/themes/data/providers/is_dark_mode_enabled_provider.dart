import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/data/providers/user_id_provider.dart';
import 'package:luciapp/main.dart';

final isDarkModeEnabledProvider = FutureProvider<bool>((ref) async {
  final userId = ref.watch(userIdProvider);
  final userSettings =
      await ref.watch(themeRepositoryProvider).get(userId ?? "");

  return userSettings?.isDarkModeEnabled ?? false;
});
