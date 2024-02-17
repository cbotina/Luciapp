import 'dart:developer';

import 'package:luciapp/common/constants/sqlite_field_name.dart';
import 'package:luciapp/common/constants/sqlite_table_name.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbFacade {
  late Database db;

  Database get connection => db;

  Future<void> open() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'luciapp.db'),
      onCreate: (db, version) {
        db.execute(
          '''
            CREATE TABLE ${SQLiteTableName.themeSettings} (
              ${SQLiteFieldName.userId} VARCHAR(150),
              ${SQLiteFieldName.isDarkModeEnabled} INTEGER,
              ${SQLiteFieldName.isHCModeEnabled} INTEGER)
          
          ''',
        );

        db.execute(
          '''
            CREATE TABLE ${SQLiteTableName.fontSettings} (
              ${SQLiteFieldName.userId} VARCHAR(150),
              ${SQLiteFieldName.scaleFactor} REAL)
          
          ''',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) {
        log("Database upgraded to v$newVersion");

        db.execute(
          '''
            DROP TABLE ${SQLiteTableName.fontSettings}
          
          ''',
        );
        db.execute(
          '''
            CREATE TABLE ${SQLiteTableName.fontSettings} (
              ${SQLiteFieldName.userId} VARCHAR(150),
              ${SQLiteFieldName.scaleFactor} REAL)

          ''',
        );
      },
      version: 6,
    );

    db = await database;
  }

  Future<void> close() async {
    await db.close();
  }
}
