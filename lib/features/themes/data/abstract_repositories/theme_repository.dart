import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';
import 'package:luciapp/features/themes/domain/models/user_theme_settings.dart';

abstract class IThemeRepository {
  Future<UserThemeSettings?> get(UserId userId);

  Future<UserThemeSettings> create(UserThemeSettings themeSettings);

  Future<bool> update(UserThemeSettings themeSettings);

  Future<void> delete(UserId userId);

  Future<List<UserThemeSettings>> getAll();
}
