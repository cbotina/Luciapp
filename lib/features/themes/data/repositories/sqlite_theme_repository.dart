import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';
import 'package:luciapp/features/themes/data/abstract_repositories/theme_repository.dart';
import 'dart:async';
import 'package:luciapp/features/themes/domain/models/theme_settings.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqLiteThemeRepository implements IThemeRepository {
  late Database db;

  @override
  Future<void> open() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'config.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE user_settings(user_id VARCHAR(150), dark_mode INTEGER, hc_mode INTEGER )',
        );
      },
      version: 3,
    );
    db = await database;
  }

  @override
  Future<void> close() async {
    await db.close();
  }

  @override
  Future<ThemeSettings?> getUserThemeSettings(UserId userId) async {
    await open();

    final ThemeSettings? themeSettings = await db
        .query('user_settings', where: 'user_id = ?', whereArgs: [userId]).then(
            (maps) => maps
                .map((e) => ThemeSettings.fromJson(e))
                .toList()
                .firstOrNull);

    await close();

    return themeSettings;
  }

  @override
  Future<bool> updateUserThemeSettings(ThemeSettings themeSettings) async {
    await open();
    final changes = await db.update('user_settings', themeSettings,
        where: 'user_id = ?', whereArgs: [themeSettings.userId]);
    return changes > 0;
  }

  @override
  Future<ThemeSettings> createUserThemeSettings(
      ThemeSettings themeSettings) async {
    await open();

    await db.insert(
      'user_settings',
      themeSettings,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await close();

    final createdUserThemeSettings =
        await getUserThemeSettings(themeSettings.userId);

    return createdUserThemeSettings!;
  }

  @override
  Future<void> deleteUserThemeSettings(UserId userId) async {
    await open();
    await db.delete('user_settings', where: 'user_id = ?', whereArgs: [userId]);
    await close();
  }

  @override
  Future<List<ThemeSettings>> getAllUsersThemeSettings() async {
    await open();
    final List<ThemeSettings> allUsersThemeSettings = await db
        .query('user_settings')
        .then((maps) => maps.map((e) => ThemeSettings.fromJson(e)).toList());
    await close();

    return allUsersThemeSettings;
  }
}
