import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luciapp/common/constants/firebase_collection_name.dart';
import 'package:luciapp/common/constants/firebase_field_name.dart';
import 'package:luciapp/features/course_progress/data/abstract_repositories/content_progress_repository.dart';
import 'package:luciapp/features/course_progress/domain/models/content_progress.dart';

class FirebaseContentProgressRepository implements IContentProgressRepository {
  @override
  Future<bool> create(ContentProgress contentProgress, String cpId) async {
    try {
      FirebaseFirestore.instance
          .collection(FirebaseCollectionName.courseProgress)
          .doc(cpId)
          .collection(FirebaseCollectionName.contentProgress)
          .add(contentProgress);
      return true;
    } catch (e) {
      return false;
    }

    // ? colocar id?
  }

  @override
  Future<void> delete(String contentId) {
    // TODO: implement delete
    throw UnimplementedError();
  }

// ! OJITOOO
  @override
  Future<ContentProgress?> get(String contentId, String cpId) async {
    try {
      final contentProgress = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.courseProgress)
          .doc(cpId)
          .collection(FirebaseCollectionName.contentProgress)
          .where(FirebaseFieldName.contentId, isEqualTo: contentId)
          .get()
          .then((json) => ContentProgress.fromSnapshot(json.docs.first));

      return contentProgress;
    } catch (e) {
      return null;
    }
  }

  /// Returns the list of all the contentprogress of a courseprogress\
  /// Example: [{"1234", true}, {"1234", true}]
  @override
  Future<List<ContentProgress>> getAll(String cpId) async {
    final query = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.courseProgress)
        .doc(cpId)
        .collection(FirebaseCollectionName.contentProgress);

    final courseProgressList = await query.get().then((value) {
      return value.docs.map((e) => ContentProgress.fromSnapshot(e));
    });

    return courseProgressList.toList();
  }

  @override
  Future<bool> update(String contentId, bool completed, String cpId) async {
    try {
      final contentProgressId = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.courseProgress)
          .doc(cpId)
          .collection(FirebaseCollectionName.contentProgress)
          .where(FirebaseFieldName.contentId, isEqualTo: contentId)
          .get()
          .then((value) => value.docs.first.id);

      FirebaseFirestore.instance
          .collection(FirebaseCollectionName.courseProgress)
          .doc(cpId)
          .collection(FirebaseCollectionName.contentProgress)
          .doc(contentProgressId)
          .update(ContentProgress(completed: completed, contentId: contentId));
      return true;
    } catch (e) {
      return false;
    }
  }
}
