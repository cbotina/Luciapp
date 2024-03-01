import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:luciapp/common/constants/firebase_field_name.dart';

@immutable
class CourseProgress extends MapView<String, dynamic> {
  final String _id;
  final String _contentId;
  final bool _completed;

  CourseProgress({required completed, required contentId, required id})
      : _completed = completed,
        _contentId = contentId,
        _id = id,
        super({
          FirebaseFieldName.contentId: contentId,
          FirebaseFieldName.completed: completed,
          'id': id,
        });

  CourseProgress.fromJson(Map<String, dynamic> json)
      : this(
          completed: json[FirebaseFieldName.completed],
          contentId: json[FirebaseFieldName.contentId],
          id: json['id'],
        );

  String get contentId => _contentId;
  bool get completed => _completed;
  String get id => _id;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseProgress &&
          runtimeType == other.runtimeType &&
          _contentId == other.contentId &&
          _completed == other.completed &&
          _id == other.id;

  @override
  int get hashCode => Object.hashAll(
        [_contentId, completed, id],
      );
}
