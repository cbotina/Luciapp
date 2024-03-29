import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luciapp/features/games/domain/models/game_level.dart';

class HangmanLevel extends GameLevel {
  final String word;
  final String hint;

  HangmanLevel(this.word, this.hint);

  HangmanLevel.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : word = snapshot.data()['word'],
        hint = snapshot.data()['hint'];
}
