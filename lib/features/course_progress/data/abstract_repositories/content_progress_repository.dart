import 'package:luciapp/features/course_progress/domain/models/content_progress.dart';

abstract class IContentProgressRepository {
  Future<ContentProgress?> get(String contentId);

  Future<bool> create(ContentProgress contentProgress);

  Future<ContentProgress> update(String contentId, bool completed);

  Future<void> delete(String contentId);

  Future<List<ContentProgress>> getAll();
}
