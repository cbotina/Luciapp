import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:luciapp/common/constants/firebase_field_name.dart';
import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';
import 'package:luciapp/features/courses/domain/typedefs/course_id.dart';

@immutable
class CourseProgress extends MapView<String, dynamic> {
  final String _id;
  final String _courseId;
  final String _userId;
  final double _percentage;

  CourseProgress({
    required id,
    required courseId,
    required userId,
    required percentage,
  })  : _userId = userId,
        _courseId = courseId,
        _id = id,
        _percentage = percentage,
        super({
          FirebaseFieldName.courseId: courseId,
          FirebaseFieldName.courseUserId: userId,
          FirebaseFieldName.percentage: percentage,
          'id': id,
        });

  CourseProgress.fromJson(Map<String, dynamic> json, String id)
      : this(
          courseId: json[FirebaseFieldName.courseId],
          userId: json[FirebaseFieldName.courseUserId],
          percentage: json[FirebaseFieldName.percentage] as double,
          id: id,
        );

  CourseProgress copyWithPercentage(double percentage) => CourseProgress(
      id: id, courseId: courseId, userId: userId, percentage: percentage);

  String get courseId => _courseId;
  String get userId => _userId;
  String get id => _id;
  double get percentage => _percentage;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseProgress &&
          runtimeType == other.runtimeType &&
          courseId == other.courseId &&
          userId == other.userId &&
          id == other.id &&
          percentage == other.percentage;

  @override
  int get hashCode => Object.hashAll(
        [
          courseId,
          userId,
          id,
          percentage,
        ],
      );
}

extension Find on List<CourseProgress> {
  CourseProgress? findByCourseIdAndUserId(CourseId courseId, UserId userId) {
    for (CourseProgress cp in this) {
      if (cp.courseId == courseId && cp.userId == userId) return cp;
    }
    return null;
  }
}
