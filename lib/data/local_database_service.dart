import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseService extends ChangeNotifier {
  static const String _databaseName = 'restaurantFavoriteList.db';
  static const String _tableName = 'restaurant_favorite';
  static const int _version = 1;

  Future<void> createTable(Database database) async {
    await database.execute('''
      CREATE TABLE $_tableName(
        id TEXT PRIMARY KEY,
        name TEXT,
        description TEXT,
        pictureId TEXT,
        city TEXT,
        rating REAL
      )
''');
  }

  Future<Database> _initializedDb() async {
    return openDatabase(
      _databaseName,
      version: _version,
      onCreate: (Database database, int version) async {
        await createTable(database);
      },
    );
  }

  Future<int> insertItem(Restaurant restaurant) async {
    final db = await _initializedDb();
    final data = restaurant.toJson();
    final id = await db.insert(
      _tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return id;
  }

  Future<Restaurant?> getItemById(String id) async {
    final db = await _initializedDb();
    final results = await db.query(
      _tableName,
      where: 'id= ?',
      whereArgs: [id],
      limit: 1,
    );

    return results.isEmpty ? null : Restaurant.fromJson(results.first);
  }

  Future<int> removeItem(String id) async {
    final db = await _initializedDb();
    final result = await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    return result;
  }
}
