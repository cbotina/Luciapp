import 'dart:collection';

import 'package:flutter/foundation.dart' show immutable;
import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';
import 'package:luciapp/features/themes/data/constants/field_names.dart';

@immutable
class ThemeSettings extends MapView<String, dynamic> {
  final UserId _userId;
  final bool _isDarkModeEnabled;
  final bool _isHCModeEnabled;

  ThemeSettings({
    required String userId,
    required bool isDarkModeEnabled,
    required bool isHCModeEnabled,
  })  : _isHCModeEnabled = isHCModeEnabled,
        _isDarkModeEnabled = isDarkModeEnabled,
        _userId = userId,
        super({
          FieldNames.userId: userId,
          FieldNames.isDarkModeEnabled: isDarkModeEnabled,
          FieldNames.isHCModeEnabled: isHCModeEnabled,
        });

  ThemeSettings.fromJson(Map<String, dynamic> json)
      : this(
          userId: json[FieldNames.userId],
          isDarkModeEnabled: json[FieldNames.isDarkModeEnabled],
          isHCModeEnabled: json[FieldNames.isHCModeEnabled],
        );

  ThemeSettings.initial(UserId userId)
      : _isHCModeEnabled = false,
        _isDarkModeEnabled = false,
        _userId = userId,
        super({
          FieldNames.userId: userId,
          FieldNames.isDarkModeEnabled: false,
          FieldNames.isHCModeEnabled: false,
        });

  ThemeSettings copyWithDarkMode(bool isDarkModeEnabled) => ThemeSettings(
        userId: userId,
        isDarkModeEnabled: isDarkModeEnabled,
        isHCModeEnabled: isHCModeEnabled,
      );

  ThemeSettings copyWithHCMode(bool isHCModeEnabled) => ThemeSettings(
        userId: userId,
        isDarkModeEnabled: isDarkModeEnabled,
        isHCModeEnabled: isHCModeEnabled,
      );

  UserId get userId => _userId;
  bool get isDarkModeEnabled => _isDarkModeEnabled;
  bool get isHCModeEnabled => _isHCModeEnabled;
}
