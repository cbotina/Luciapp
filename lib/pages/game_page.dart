import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/common/extensions/int_to_duration.dart';
import 'package:luciapp/features/course_progress/presentation/controllers/active_content_controller.dart';
import 'package:luciapp/features/courses/data/providers/courses_provider.dart';
import 'package:luciapp/features/courses/presentation/widgets/course_content_list.dart';
import 'package:luciapp/features/games/data/providers/games_provider.dart';
import 'package:luciapp/features/games/domain/enums/game_type.dart';
import 'package:luciapp/features/games/presentation/hangman_screen.dart';
import 'package:luciapp/features/games/presentation/trivia_screen.dart';

// class GamePage extends ConsumerWidget {
//   final String gameId;
//   const GamePage({super.key, required this.gameId});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // final game = ref.watch(courseGameProvider(gameId)).value;
//     // final levels =
//     //     ref.watch(gameLevelsProvider(GameInfo(gameId, game!.type))).value;

//     // switch (game.type) {
//     //   case GameType.hangman:
//     //     return HangmanScreen(levels: levels!, mode: GameMode.custom);
//     //   case GameType.trivia:
//     //     return TriviaScreen(levels: levels!, mode: GameMode.custom);
//     // }

//     ref.invalidate(courseGameProvider);
//     final gameAsync = ref.read(courseGameProvider(gameId));

//     // print('CONTENT ID:');
//     // print(ref.read(activeContentControllerProvider).contentId);
//     // print('COURSE ID:');
//     // print(ref.read(activeContentControllerProvider).courseId);
//     // print('USER ID:');
//     // print(ref.read(activeContentControllerProvider).userId);

//     return gameAsync.when(
//       data: (data) {
//         switch (data!.type) {
//           case GameType.hangman:
//             return HangmanPage(gameId: gameId);
//           case GameType.trivia:
//             return TriviaPage(gameId: gameId);
//         }
//       },
//       error: (error, stackTrace) => Text(error.toString()),
//       loading: () => const CircularProgressIndicator(),
//     );
//   }
// }

class GamePage extends ConsumerStatefulWidget {
  final String gameId;
  const GamePage({super.key, required this.gameId});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GamePageState();
}

class _GamePageState extends ConsumerState<GamePage> {
  @override
  Widget build(BuildContext context) {
    ref.invalidate(courseGameProvider);
    final gameAsync = ref.read(courseGameProvider(widget.gameId));

    return gameAsync.when(
      data: (data) {
        switch (data!.type) {
          case GameType.hangman:
            return HangmanPage(gameId: widget.gameId);
          case GameType.trivia:
            return TriviaPage(gameId: widget.gameId);
        }
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const CircularProgressIndicator(),
    );
  }
}

class NumberNotifier extends StateNotifier<int> {
  NumberNotifier() : super(0);

  void increase() {
    state = state + 1;
  }
}

final numberProvider = StateNotifierProvider<NumberNotifier, int>((ref) {
  return NumberNotifier();
});
