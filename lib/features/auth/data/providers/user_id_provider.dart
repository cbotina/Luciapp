import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/main.dart';

final userIdProvider = Provider<String?>((ref) {
  return ref.read(authRepositoryProvider).userId;
});
