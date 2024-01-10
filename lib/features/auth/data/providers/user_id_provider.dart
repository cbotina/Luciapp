import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/main.dart';

final userIdProvider = Provider.autoDispose<String?>((ref) {
  return ref.read(authRepositoryProvider).userId;
});
