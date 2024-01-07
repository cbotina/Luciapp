import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/main.dart';

final photoUrlProvider = Provider<String?>((ref) {
  return ref.watch(authRepositoryProvider).photoUrl;
});
