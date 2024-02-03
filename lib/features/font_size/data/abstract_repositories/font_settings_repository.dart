import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';
import 'package:luciapp/features/font_size/domain/models/user_font_settings.dart';

abstract class IFontSettingsRepository {
  Future<UserFontSettings?> get(UserId userId);

  Future<UserFontSettings> create(UserFontSettings fontSettings);

  Future<bool> update(UserFontSettings fontSettings);

  Future<void> delete(UserId userId);

  Future<List<UserFontSettings>> getAll();
}
