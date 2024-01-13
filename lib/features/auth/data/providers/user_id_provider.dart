import 'package:luciapp/main.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userIdProvider = Provider.autoDispose<String?>((ref) {
  return ref.read(authRepositoryProvider).userId;
});
