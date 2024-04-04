import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luciapp/features/courses/data/abstract_repositories/course_content_repository.dart';
import 'package:luciapp/features/courses/domain/models/course_content.dart';
import 'package:luciapp/features/courses/domain/typedefs/course_id.dart';

class FirebaseCourseContentsRepository implements CourseContentsRepository {
  @override
  Future<List<CourseContent>> getCourseContents(CourseId id) async {
    final contents = FirebaseFirestore.instance
        .collection('courses')
        .doc(id)
        .collection('contents')
        .orderBy('index');

    final contentsList = await contents.get().then((value) {
      return value.docs.map((doc) => CourseContent.fromSnapshot(doc));
    });

    return contentsList.toList();
  }
}
