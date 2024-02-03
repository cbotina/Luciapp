import 'package:luciapp/common/constants/sqlite_field_name.dart';
import 'package:luciapp/common/constants/sqlite_table_name.dart';
import 'package:luciapp/common/local_db/db_facade.dart';
import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';
import 'package:luciapp/features/themes/data/abstract_repositories/theme_settings_repository.dart';
import 'dart:async';
import 'package:luciapp/features/themes/domain/models/user_theme_settings.dart';
import 'package:sqflite/sqflite.dart';

class SqLiteThemeSettingsRepository implements IThemeSettingsReposiroty {
  final DbFacade facade = DbFacade();

  @override
  Future<UserThemeSettings?> get(UserId userId) async {
    await facade.open();

    final UserThemeSettings? themeSettings = await facade.connection.query(
        SQLiteTableName.themeSettings,
        where: '${SQLiteFieldName.userId} = ?',
        whereArgs: [
          userId
        ]).then((maps) =>
        maps.map((e) => UserThemeSettings.fromJson(e)).toList().firstOrNull);

    // await facade.close();

    return themeSettings;
  }

  @override
  Future<bool> update(UserThemeSettings themeSettings) async {
    await facade.open();

    final changes = await facade.connection.update(
        SQLiteTableName.themeSettings, themeSettings,
        where: '${SQLiteFieldName.userId} = ?',
        whereArgs: [themeSettings.userId]);

    // await facade.close();
    return changes > 0;
  }

  @override
  Future<UserThemeSettings> create(UserThemeSettings themeSettings) async {
    await facade.open();

    await facade.connection.insert(
      SQLiteTableName.themeSettings,
      themeSettings,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // await facade.close();

    final createdUserThemeSettings = await get(themeSettings.userId);

    return createdUserThemeSettings!;
  }

  @override
  Future<void> delete(UserId userId) async {
    await facade.open();
    await facade.connection.delete(SQLiteTableName.themeSettings,
        where: '${SQLiteFieldName.userId} = ?', whereArgs: [userId]);
    //await facade.close();
  }

  @override
  Future<List<UserThemeSettings>> getAll() async {
    await facade.open();
    final List<UserThemeSettings> allUsersThemeSettings =
        await facade.connection.query(SQLiteTableName.themeSettings).then(
            (maps) => maps.map((e) => UserThemeSettings.fromJson(e)).toList());
    // await facade.close();

    return allUsersThemeSettings;
  }
}
