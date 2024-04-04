import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/games/domain/models/game.dart';
import 'package:luciapp/main.dart';

final courseGameProvider =
    FutureProvider.family<Game?, String>((ref, id) async {
  return await ref.read(gamesRepositoryProvider).get(id);
});
