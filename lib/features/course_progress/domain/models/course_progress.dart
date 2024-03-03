import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:luciapp/common/constants/firebase_field_name.dart';

@immutable
class CourseProgress extends MapView<String, dynamic> {
  final String _id;
  final String _courseId;
  final String _userId;

  CourseProgress({required id, required courseId, required userId})
      : _userId = userId,
        _courseId = courseId,
        _id = id,
        super({
          FirebaseFieldName.courseId: courseId,
          FirebaseFieldName.courseUserId: userId,
          'id': id,
        });

  CourseProgress.fromJson(Map<String, dynamic> json, String id)
      : this(
          courseId: json[FirebaseFieldName.courseId],
          userId: json[FirebaseFieldName.courseUserId],
          id: id,
        );

  String get courseId => _courseId;
  String get userId => _userId;
  String get id => _id;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseProgress &&
          runtimeType == other.runtimeType &&
          _courseId == other.courseId &&
          _userId == other.userId &&
          _id == other.id;

  @override
  int get hashCode => Object.hashAll(
        [courseId, userId, id],
      );
}
