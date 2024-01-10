import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/domain/enums/auth_result.dart';
import 'package:luciapp/features/auth/presentation/controllers/auth_controller.dart';

final authResultProvider = Provider.autoDispose<AuthResult>((ref) {
  return ref.watch(authControllerProvider).result;
});
