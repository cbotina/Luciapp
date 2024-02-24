import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luciapp/features/games/data/abstract_repositories/game_levels_repositoryl.dart';
import 'package:luciapp/features/games/domain/enums/game_type.dart';
import 'package:luciapp/features/games/domain/models/game_level.dart';
import 'package:luciapp/features/games/domain/models/hangman_level.dart';
import 'package:luciapp/features/games/domain/models/trivia_level.dart';

class FirebaseGameLevelsRepository implements IGameLevelsRepository {
  @override
  Future<List<GameLevel>> getAll(String gameId, GameType type) async {
    final contents = FirebaseFirestore.instance
        .collection('games')
        .doc(gameId)
        .collection('levels');

    final contentsList = await contents.get().then((value) {
      return value.docs.map((doc) {
        switch (type) {
          case GameType.hangman:
            return HangmanLevel.fromSnapshot(doc);
          case GameType.trivia:
            return TriviaLevel.fromSnapshot(doc);
        }
      });
    });

    return contentsList.toList();
  }
}
