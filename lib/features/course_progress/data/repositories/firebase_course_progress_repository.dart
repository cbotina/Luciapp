import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luciapp/common/constants/firebase_collection_name.dart';
import 'package:luciapp/common/constants/firebase_field_name.dart';
import 'package:luciapp/features/course_progress/data/abstract_repositories/course_progress_repository.dart';
import 'package:luciapp/features/course_progress/domain/models/course_progress.dart';

class FirebaseCourseProgressRepository implements ICourseProgressRepository {
  @override
  Future<bool> create(String courseId, String userId) async {
    try {
      FirebaseFirestore.instance
          .collection(FirebaseCollectionName.courseProgress)
          .add({
        FirebaseFieldName.courseUserId: userId,
        FirebaseFieldName.courseId: courseId,
      });
    } catch (e) {
      return false;
    }
    return true;
  }

  @override
  Future<void> delete(String cpId) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<CourseProgress?> get(String courseId, String userId) async {
    final courseProgress = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.courseProgress)
        .where(FirebaseFieldName.courseUserId, isEqualTo: userId)
        .where(FirebaseFieldName.courseId, isEqualTo: courseId)
        .limit(1)
        .get();

    if (courseProgress.docs.isNotEmpty) {
      return CourseProgress.fromJson(courseProgress.docs.first.data());
    } else {
      return null;
    }
  }
}
