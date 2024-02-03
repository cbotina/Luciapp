import 'dart:collection';

import 'package:luciapp/common/constants/sqlite_field_name.dart';
import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';

class UserFontSettings extends MapView<String, dynamic> {
  final UserId _userId;
  final double _scaleFactor;

  UserFontSettings({
    required double scaleFactor,
    required UserId userId,
  })  : _userId = userId,
        _scaleFactor = scaleFactor,
        super({
          SQLiteFieldName.scaleFactor: scaleFactor,
          SQLiteFieldName.userId: userId,
        });

  UserFontSettings.initial(UserId userId)
      : _userId = userId,
        _scaleFactor = 1.0,
        super({
          SQLiteFieldName.scaleFactor: 1.0,
          SQLiteFieldName.userId: userId,
        });

  UserFontSettings.fromJson(Map<String, dynamic> json)
      : this(
          userId: json[SQLiteFieldName.userId],
          scaleFactor: json[SQLiteFieldName.scaleFactor],
        );

  UserFontSettings copyWithScaleFactor(double scaleFactor) =>
      UserFontSettings(scaleFactor: scaleFactor, userId: userId);

  double get scaleFactor => _scaleFactor;
  UserId get userId => _userId;
}
