import 'package:luciapp/features/games/domain/enums/game_type.dart';
import 'package:luciapp/features/games/domain/models/game_level.dart';
import 'package:luciapp/features/games/domain/typedefs/game_id.dart';

abstract class IGameLevelsRepository {
  Future<List<GameLevel>> getAll(GameId gameId, GameType type);
}
