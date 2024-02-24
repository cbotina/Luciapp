import 'package:luciapp/features/games/domain/models/game.dart';

abstract class IGamesRepository {
  Future<Game?> get(String gameId);
}
