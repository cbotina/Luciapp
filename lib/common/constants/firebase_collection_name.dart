import 'package:flutter/foundation.dart' show immutable;

@immutable
class FirebaseCollectionName {
  static const users = 'users';

  static const courseProgress = 'course_progress';

  static const contentProgress = 'content_progress';

  const FirebaseCollectionName._();
}
