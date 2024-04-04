import 'package:flutter/foundation.dart';
import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';

@immutable
class ActiveContentState {
  final String? courseId;
  final String? contentId;
  final String? userId;
  final int? nContents;

  const ActiveContentState({
    required this.courseId,
    required this.contentId,
    required this.userId,
    required this.nContents,
  });

  const ActiveContentState.initial()
      : courseId = null,
        contentId = null,
        userId = null,
        nContents = null;

  ActiveContentState copyWithUserId(UserId userId) => ActiveContentState(
        courseId: courseId,
        contentId: contentId,
        userId: userId,
        nContents: nContents,
      );

  ActiveContentState copyWithCourseId(String courseId) => ActiveContentState(
        courseId: courseId,
        contentId: contentId,
        userId: userId,
        nContents: nContents,
      );

  ActiveContentState copyWithContentId(String contentId) => ActiveContentState(
        courseId: courseId,
        contentId: contentId,
        userId: userId,
        nContents: nContents,
      );

  ActiveContentState copyWithNContents(int nContents) => ActiveContentState(
        courseId: courseId,
        contentId: contentId,
        userId: userId,
        nContents: nContents,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActiveContentState &&
          runtimeType == other.runtimeType &&
          courseId == other.courseId &&
          contentId == other.contentId &&
          userId == other.contentId;

  @override
  int get hashCode => Object.hashAll(
        [courseId, contentId, userId],
      );
}
