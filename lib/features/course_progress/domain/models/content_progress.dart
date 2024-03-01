import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:luciapp/common/constants/firebase_field_name.dart';

@immutable
class ContentProgress extends MapView<String, dynamic> {
  final String _contentId;
  final bool _completed;

  ContentProgress({required completed, contentId})
      : _completed = completed,
        _contentId = contentId,
        super({
          FirebaseFieldName.contentId: contentId,
          FirebaseFieldName.completed: completed,
        });

  ContentProgress.fromJson(Map<String, dynamic> json)
      : this(
          completed: json[FirebaseFieldName.completed],
          contentId: json[FirebaseFieldName.contentId],
        );

  String get contentId => _contentId;
  bool get completed => _completed;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContentProgress &&
          runtimeType == other.runtimeType &&
          _contentId == other.contentId &&
          _completed == other.completed;

  @override
  int get hashCode => Object.hashAll(
        [_contentId, completed],
      );
}
