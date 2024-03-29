import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luciapp/common/constants/firebase_field_name.dart';
import 'package:luciapp/features/courses/data/abstract_repositories/courses_repository.dart';
import 'package:luciapp/features/courses/domain/models/course.dart';

class FirebaseCourseRepository implements CoursesRepository {
  @override
  Future<List<Course>> getCourses() async {
    final courses = FirebaseFirestore.instance
        .collection('courses')
        .where(FirebaseFieldName.published, isEqualTo: true);

    final coursesList = await courses.get().then((value) {
      return value.docs.map((doc) => Course.fromSnapshot(doc));
    });

    return coursesList.toList();
  }
}
