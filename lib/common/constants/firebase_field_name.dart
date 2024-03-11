import 'package:flutter/foundation.dart' show immutable;

@immutable
class FirebaseFieldName {
  static const userId = 'id';
  static const username = 'name';
  static const gender = 'gender';
  static const age = 'age';

  static const courseUserId = 'user_id';
  static const courseId = 'course_id';

  static const contentId = 'content_id';
  static const completed = 'completed';
  static const percentage = 'percentage_completed';
  static const published = 'published';

  const FirebaseFieldName._();
}
