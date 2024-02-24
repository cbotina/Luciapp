import 'package:luciapp/features/games/domain/enums/game_type.dart';
import 'package:luciapp/features/games/domain/models/game_level.dart';

abstract class IGameLevelsRepository {
  Future<List<GameLevel>> getAll(String gameId, GameType type);
}
