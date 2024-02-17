import 'package:flutter/foundation.dart' show immutable;

@immutable
class SQLiteFieldName {
  static const userId = 'user_id';
  static const isDarkModeEnabled = 'dark_mode';
  static const isHCModeEnabled = 'hc_mode';
  static const scaleFactor = 'scale_factor';

  const SQLiteFieldName._();
}
