import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';
import 'package:luciapp/features/themes/domain/models/theme_settings.dart';

abstract class IThemeRepository {
  void open();
  void close();
  Future<ThemeSettings?> getUserThemeSettings(UserId userId);

  Future<ThemeSettings> createUserThemeSettings(ThemeSettings themeSettings);

  Future<bool> updateUserThemeSettings(ThemeSettings themeSettings);

  Future<void> deleteUserThemeSettings(UserId userId);

  Future<List<ThemeSettings>> getAllUsersThemeSettings();
}
