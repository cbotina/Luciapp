import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luciapp/features/games/data/abstract_repositories/games_repository.dart';
import 'package:luciapp/features/games/domain/models/game.dart';
import 'package:luciapp/features/games/domain/typedefs/game_id.dart';

class FirebaseGamesRepository implements IGamesRepository {
  @override
  Future<Game?> get(GameId gameId) async {
    final games = FirebaseFirestore.instance.collection('games');

    final game = await games.doc(gameId).get().then((value) {
      if (value.exists) {
        return Game.fromSnapshot(value);
      } else {
        return null;
      }
    });

    return game;
  }
}
