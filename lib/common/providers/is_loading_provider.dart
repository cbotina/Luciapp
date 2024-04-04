import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/presentation/controllers/auth_controller.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authControllerProvider);
  return authState.isLoading;
});
