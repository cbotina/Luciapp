import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luciapp/features/games/domain/enums/game_mode.dart';
import 'package:luciapp/features/games/domain/enums/game_type.dart';

class Game {
  final String id;
  final GameMode mode;
  final GameType type;

  Game({
    required this.id,
    required this.mode,
    required this.type,
  });

  Game.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        mode = snapshot.data()!['mode'].toString().toGameMode(),
        type = snapshot.data()!['type'].toString().toGameType();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Game &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          mode == other.mode &&
          type == other.type;

  @override
  int get hashCode => Object.hashAll(
        [
          id,
          mode,
          type,
        ],
      );
}
