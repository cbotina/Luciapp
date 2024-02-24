import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luciapp/features/games/domain/models/game_level.dart';

class TriviaLevel extends GameLevel {
  final String question;
  final bool answer;
  final String imagePath;
  final String explaination;

  TriviaLevel({
    required this.question,
    required this.answer,
    required this.imagePath,
    required this.explaination,
  });

  TriviaLevel.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : question = snapshot.data()['question'],
        answer = snapshot.data()['answer'],
        explaination = snapshot.data()['explaination'],
        imagePath = snapshot.data()['imagePath'];
}
