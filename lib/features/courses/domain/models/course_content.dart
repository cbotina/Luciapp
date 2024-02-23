import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luciapp/features/courses/domain/enums/content_types.dart';
import 'package:luciapp/features/courses/domain/typedefs/course_id.dart';

class CourseContent {
  final CourseId courseId;
  final int index;
  final String name;
  final String description;
  final ContentTypes type;
  final String? url;
  final String? gameId;

  CourseContent({
    required this.courseId,
    required this.index,
    required this.name,
    required this.type,
    required this.description,
    this.url,
    this.gameId,
  });

  CourseContent.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : courseId = snapshot.id,
        name = snapshot.data()['name'],
        description = snapshot.data()['description'],
        index = snapshot.data()['index'],
        type = snapshot.data()['type'].toString().toContentType(),
        url = snapshot.data()['url'],
        gameId = snapshot.data()['game_id'];
}
