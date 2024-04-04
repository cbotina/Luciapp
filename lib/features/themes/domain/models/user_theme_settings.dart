import 'dart:collection';
import 'package:flutter/foundation.dart' show immutable;
import 'package:luciapp/common/constants/sqlite_field_name.dart';
import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';

@immutable
class UserThemeSettings extends MapView<String, dynamic> {
  final UserId _userId;
  final bool _isDarkModeEnabled;
  final bool _isHCModeEnabled;

  UserThemeSettings({
    required String userId,
    required bool isDarkModeEnabled,
    required bool isHCModeEnabled,
  })  : _isHCModeEnabled = isHCModeEnabled,
        _isDarkModeEnabled = isDarkModeEnabled,
        _userId = userId,
        super({
          SQLiteFieldName.userId: userId,
          SQLiteFieldName.isDarkModeEnabled: isDarkModeEnabled ? 1 : 0,
          SQLiteFieldName.isHCModeEnabled: isHCModeEnabled ? 1 : 0,
        });

  UserThemeSettings.fromJson(Map<String, dynamic> json)
      : this(
          userId: json[SQLiteFieldName.userId],
          isDarkModeEnabled: json[SQLiteFieldName.isDarkModeEnabled] == 1,
          isHCModeEnabled: json[SQLiteFieldName.isHCModeEnabled] == 1,
        );

  UserThemeSettings.initial(UserId userId)
      : _isHCModeEnabled = false,
        _isDarkModeEnabled = false,
        _userId = userId,
        super({
          SQLiteFieldName.userId: userId,
          SQLiteFieldName.isDarkModeEnabled: 0,
          SQLiteFieldName.isHCModeEnabled: 0,
        });

  UserThemeSettings copyWithDarkMode(bool isDarkModeEnabled) =>
      UserThemeSettings(
        userId: userId,
        isDarkModeEnabled: isDarkModeEnabled,
        isHCModeEnabled: isHCModeEnabled,
      );

  UserThemeSettings copyWithHCMode(bool isHCModeEnabled) => UserThemeSettings(
        userId: userId,
        isDarkModeEnabled: isDarkModeEnabled,
        isHCModeEnabled: isHCModeEnabled,
      );

  UserId get userId => _userId;
  bool get isDarkModeEnabled => _isDarkModeEnabled;
  bool get isHCModeEnabled => _isHCModeEnabled;
}
