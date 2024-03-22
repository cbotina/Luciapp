import 'package:luciapp/features/course_progress/domain/models/content_progress.dart';
import 'package:luciapp/features/course_progress/domain/typedefs/content_id.dart';

abstract class IContentProgressRepository {
  Future<ContentProgress?> get(ContentId contentId, String cpId);

  Future<bool> create(ContentProgress contentProgress, String cpId);

  Future<bool> update(ContentId contentId, bool completed, String cpId);

  Future<void> delete(ContentId contentId);

  Future<List<ContentProgress>> getAll(String cpId);
}
