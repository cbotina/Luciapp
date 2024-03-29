import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/attributions/domain/models/attribution.dart';
import 'package:luciapp/main.dart';

final attributionsProvider = FutureProvider<List<Attribution>>((ref) async {
  return ref.watch(attributionsRepositoryProvider).getAll();
});
