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
      join(await getDatabasesPath(), 'configurations.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE user_settings(id VARCHAR(150), dark_mode BOOL, hc_mode BOOL )',
        );
      },
      version: 1,
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
        .query('user_settings')
        .then((maps) => ThemeSettings.fromJson(maps[1]));

    await close();

    return themeSettings;
  }

  @override
  Future<bool> updateUserThemeSettings(
      UserId userId, ThemeSettings themeSettings) async {
    await open();
    final changes = await db.update('user_settings', themeSettings,
        where: 'id = ?', whereArgs: [userId]);
    return changes > 0;
  }

  @override
  Future<ThemeSettings> createUserThemeSettings(
      UserId userId, ThemeSettings themeSettings) async {
    await open();

    await db.insert(
      'user_settings',
      themeSettings,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await close();

    final createdUserThemeSettings = await getUserThemeSettings(userId);

    return createdUserThemeSettings!;
  }
}
