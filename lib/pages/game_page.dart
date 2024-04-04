import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/games/data/providers/games_provider.dart';
import 'package:luciapp/features/games/domain/enums/game_type.dart';
import 'package:luciapp/features/games/presentation/hangman_screen.dart';
import 'package:luciapp/features/games/presentation/trivia_screen.dart';
import 'package:luciapp/pages/game_not_found_page.dart';

class GamePage extends StatelessWidget {
  final String gameId;
  const GamePage({super.key, required this.gameId});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final gameAsync = ref.watch(courseGameProvider(gameId));

        return gameAsync.when(
          data: (data) {
            if (data == null) {
              return const GameNotFoundPage();
            } else {
              switch (data.type) {
                case GameType.hangman:
                  return HangmanPage(gameId: gameId);
                case GameType.trivia:
                  return TriviaPage(gameId: gameId);
              }
            }
          },
          error: (error, stackTrace) => Text(error.toString()),
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      },
    );
  }
}
