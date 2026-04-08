import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otakukitchen/features/recipes/data/sources/recipe_local_datasource.dart';
import 'package:sqflite/sqflite.dart';

final databaseProvider = Provider<Database>((ref) {
  throw UnimplementedError(
    'Initialize your database and override this provider',
  );
});

final recipeLocalDataSourceProvider = Provider<RecipeLocalDataSource>((ref) {
  final db = ref.watch(databaseProvider);
  return RecipeLocalDataSourceImpl(db: db);
});
