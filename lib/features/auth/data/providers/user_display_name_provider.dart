import 'package:luciapp/main.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userDisplayNameProvider = Provider.autoDispose<String?>((ref) {
  return ref.read(authRepositoryProvider).displayName;
});
