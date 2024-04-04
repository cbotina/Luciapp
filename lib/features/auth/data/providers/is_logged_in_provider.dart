import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/domain/enums/auth_result.dart';
import 'package:luciapp/features/auth/data/providers/auth_result_provider.dart';

final isLoggedInProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(authResultProvider) == AuthResult.success;
});
