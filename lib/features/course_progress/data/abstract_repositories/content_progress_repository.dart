import 'package:luciapp/features/course_progress/domain/models/content_progress.dart';

abstract class IContentProgressRepository {
  Future<ContentProgress?> get(String contentId, String cpId);

  Future<bool> create(ContentProgress contentProgress, String cpId);

  Future<bool> update(String contentId, bool completed, String cpId);

  Future<void> delete(String contentId);

  Future<List<ContentProgress>> getAll(String cpId);
}
