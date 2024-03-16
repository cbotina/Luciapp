import 'package:luciapp/features/games/domain/models/game.dart';
import 'package:luciapp/features/games/domain/typedefs/game_id.dart';

abstract class IGamesRepository {
  Future<Game?> get(GameId gameId);
}
