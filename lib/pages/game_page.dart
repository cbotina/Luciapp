import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/games/data/providers/game_levels_provider.dart';
import 'package:luciapp/features/games/data/providers/games_provider.dart';
import 'package:luciapp/features/games/domain/enums/game_mode.dart';
import 'package:luciapp/features/games/domain/enums/game_type.dart';
import 'package:luciapp/features/games/domain/models/hangman_level.dart';
import 'package:luciapp/features/games/presentation/hangman_screen.dart';

class GamePage extends ConsumerWidget {
  final String gameId;
  const GamePage({super.key, required this.gameId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(courseGameProvider(gameId));
    final levels = ref.watch(hangmanLevelsProvider(gameId));

    final defaultlevels = [HangmanLevel('siu', 'siu')];

    final levelss = levels.when(
      data: (data) => data,
      error: (error, stackTrace) => defaultlevels,
      loading: () => defaultlevels,
    );

    return game.when(
      data: (data) {
        switch (data!.type) {
          case GameType.hangman:
            return HangmanScreen(levels: levelss, mode: GameMode.custom);
          case GameType.trivia:
            return const Text("no");
        }

        // return Text(levels.maybeWhen(orElse: () => ['siu']).toString());
        // return Text(
        //   "${data!.id} ${data.mode.toString()} ${data.type.toString()}",
        // );
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
