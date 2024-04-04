import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/games/domain/enums/game_type.dart';
import 'package:luciapp/features/games/domain/models/game_level.dart';
import 'package:luciapp/main.dart';

final hangmanLevelsProvider =
    FutureProvider.family<List<GameLevel>, String>((ref, gameId) async {
  return await ref
      .watch(gameLevelsRepositoryProvider)
      .getAll(gameId, GameType.hangman);
});

final triviaLevelsProvider =
    FutureProvider.family<List<GameLevel>, String>((ref, gameId) async {
  return await ref
      .watch(gameLevelsRepositoryProvider)
      .getAll(gameId, GameType.trivia);
});
