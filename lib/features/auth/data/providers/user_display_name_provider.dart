import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/main.dart';

final userDisplayNameProvider = Provider<String?>((ref) {
  return ref.read(authRepositoryProvider).displayName;
});
