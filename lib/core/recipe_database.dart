import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

///initializes database
Future<Database> initDB(String filePath) async {
  final dbPath = await getDatabasesPath();
  final path = p.join(dbPath, filePath);
  bool ifDatabaseExists = await databaseExists(path);
  if (ifDatabaseExists) return await openDatabase(path, version: 1);
  ByteData data = await rootBundle.load("assets/recipes.db");
  List<int> bytes = data.buffer.asUint8List(
    data.offsetInBytes,
    data.lengthInBytes,
  );
  await File(path).writeAsBytes(bytes);
  return await openDatabase(path, version: 1);
}
