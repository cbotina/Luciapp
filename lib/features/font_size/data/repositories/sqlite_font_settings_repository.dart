import 'package:luciapp/common/constants/sqlite_field_name.dart';
import 'package:luciapp/common/constants/sqlite_table_name.dart';
import 'package:luciapp/common/local_db/db_facade.dart';
import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';
import 'package:luciapp/features/font_size/data/abstract_repositories/font_settings_repository.dart';
import 'package:luciapp/features/font_size/domain/models/user_font_settings.dart';
import 'package:sqflite/sqflite.dart';

class SqLiteFontSettingsRepository implements IFontSettingsRepository {
  final DbFacade facade = DbFacade();

  @override
  Future<UserFontSettings> create(UserFontSettings fontSettings) async {
    await facade.open();

    await facade.connection.insert(
      SQLiteTableName.fontSettings,
      fontSettings,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    //await facade.close();

    final createdUserFontSettings = await get(fontSettings.userId);

    return createdUserFontSettings!;
  }

  @override
  Future<void> delete(UserId userId) async {
    await facade.open();
    await facade.connection.delete(SQLiteTableName.fontSettings,
        where: '${SQLiteFieldName.userId} = ?', whereArgs: [userId]);
    //await facade.close();
  }

  @override
  Future<UserFontSettings?> get(UserId userId) async {
    await facade.open();

    final UserFontSettings? fontSettings = await facade.connection.query(
        SQLiteTableName.fontSettings,
        where: '${SQLiteFieldName.userId} = ?',
        whereArgs: [
          userId
        ]).then((maps) =>
        maps.map((e) => UserFontSettings.fromJson(e)).toList().firstOrNull);

    //await facade.close();

    return fontSettings;
  }

  @override
  Future<List<UserFontSettings>> getAll() async {
    await facade.open();

    final List<UserFontSettings> allUsersFontSettings = await facade.connection
        .query(SQLiteTableName.fontSettings)
        .then((maps) => maps.map((e) => UserFontSettings.fromJson(e)).toList());

    //await facade.close();

    return allUsersFontSettings;
  }

  @override
  Future<bool> update(UserFontSettings fontSettings) async {
    await facade.open();

    final changes = await facade.connection.update(
        SQLiteTableName.fontSettings, fontSettings,
        where: '${SQLiteFieldName.userId} = ?',
        whereArgs: [fontSettings.userId]);

    //await facade.close();
    return changes > 0;
  }
}
