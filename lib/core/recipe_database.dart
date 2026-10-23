import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

/// Initializes the database
Future<Database> initDB(String filePath) async {
  final dbPath = await getDatabasesPath();
  final path = p.join(dbPath, filePath);
  bool ifDatabaseExists = await databaseExists(path);

  if (!ifDatabaseExists) {
    ByteData data = await rootBundle.load("assets/recipes.db");
    List<int> bytes = data.buffer.asUint8List(
      data.offsetInBytes,
      data.lengthInBytes,
    );
    await File(path).writeAsBytes(bytes);
  }

  return await openDatabase(
    path,
    version: 3,
    onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < 2) {
        try {
          await db.execute(
            'ALTER TABLE recipes ADD COLUMN is_cooked INTEGER DEFAULT 0',
          );
        } catch (e) {
          if (kDebugMode) {
            print("Migration error: $e");
          }
        }
      }
      if (oldVersion < 3) {
        try {
          final String sqlScript = await rootBundle.loadString('assets/new_recipes.sql');

          final List<String> queries = sqlScript
              .split(';')
              .map((q) => q.trim())
              .where((q) => q.isNotEmpty)
              .toList();

          final batch = db.batch();
          for (var query in queries) {
            batch.execute(query);
          }

          await batch.commit(noResult: true);

          if (kDebugMode) print("Успешно выполнено ${queries.length} запросов!");
        } catch (e) {
          if (kDebugMode) print("Ошибка миграции: $e");
          rethrow;
        }
      }

    },
  );
}
