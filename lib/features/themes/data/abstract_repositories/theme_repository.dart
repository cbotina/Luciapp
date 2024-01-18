import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';
import 'package:luciapp/features/themes/domain/models/theme_settings.dart';

abstract class IThemeRepository {
  void open();
  void close();
  Future<ThemeSettings?> getUserThemeSettings(UserId userId);
  Future<ThemeSettings> createUserThemeSettings(
      UserId userId, ThemeSettings themeSettings);
  Future<bool> updateUserThemeSettings(
    UserId userId,
    ThemeSettings themeSettings,
  );
}
