import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luciapp/common/constants/firebase_collection_name.dart';
import 'package:luciapp/common/constants/firebase_field_name.dart';
import 'package:luciapp/features/course_progress/data/abstract_repositories/course_progress_repository.dart';
import 'package:luciapp/features/course_progress/domain/models/course_progress.dart';

class FirebaseCourseProgressRepository implements ICourseProgressRepository {
  @override
  Future<CourseProgress> create(String courseId, String userId) async {
    await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.courseProgress)
        .add({
      FirebaseFieldName.courseUserId: userId,
      FirebaseFieldName.courseId: courseId,
      FirebaseFieldName.percentage: 0.0,
    });

    final created = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.courseProgress)
        .where(FirebaseFieldName.courseUserId, isEqualTo: userId)
        .where(FirebaseFieldName.courseId, isEqualTo: courseId)
        .limit(1)
        .get();

    return CourseProgress.fromJson(
      created.docs.first.data(),
      created.docs.first.id,
    );
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
      return CourseProgress.fromJson(
          courseProgress.docs.first.data(), courseProgress.docs.first.id);
    } else {
      return null;
    }
  }

  @override
  Future<bool> update(CourseProgress courseProgress) async {
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.courseProgress)
          .doc(courseProgress.id)
          .update(courseProgress);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<CourseProgress>> getAll() {
    return FirebaseFirestore.instance
        .collection(FirebaseCollectionName.courseProgress)
        .get()
        .then((value) => value.docs
            .map((e) => CourseProgress.fromJson(e.data(), e.id))
            .toList());
  }
}
