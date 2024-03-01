import 'package:luciapp/features/course_progress/data/abstract_repositories/content_progress_repository.dart';
import 'package:luciapp/features/course_progress/domain/models/content_progress.dart';

class FirebaseContentProgressRepository implements IContentProgressRepository {
  @override
  Future<bool> create(ContentProgress contentProgress) async {
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String contentId) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<ContentProgress?> get(String contentId) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<List<ContentProgress>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<ContentProgress> update(String contentId, bool completed) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
