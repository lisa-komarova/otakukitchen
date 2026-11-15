import 'package:otakukitchen/features/recipes/data/models/anime_model.dart';
import 'package:otakukitchen/features/recipes/data/models/category_model.dart';
import 'package:otakukitchen/features/recipes/data/models/ingredient_group_model.dart';
import 'package:otakukitchen/features/recipes/data/models/ingredient_in_recipe_model.dart';
import 'package:otakukitchen/features/recipes/data/models/ingredient_model.dart';
import 'package:otakukitchen/features/recipes/data/models/recipe_model.dart';
import 'package:otakukitchen/features/recipes/data/models/recipe_section_model.dart';
import 'package:otakukitchen/features/recipes/data/models/step_model.dart';
import 'package:sqflite/sqflite.dart';

import '../models/recipe_card_info_model.dart';

abstract class RecipeLocalDataSource {
  Future<RecipeModel> getRecipeById(int recipeId);
  Future<List<RecipeCardInfoModel>> getRecipesByCategory(String category);
  Future<CategoryModel> getCategory(int categoryId);
  Future<List<CategoryModel>> getCategories();
  Future<List<AnimeModel>> getAnimesByRecipe(int recipeId);
  Future<int> getRecipesAmount();
  Future<List<IngredientGroupModel>> getIngredientGroups(int recipeId);
  Future<List<IngredientInRecipeModel>> getIngredientsInRecipe(int recipeId);

  Future<List<RecipeSection>> getRecipeSections(int recipeId);
  Future<List<Step>> getSteps(int recipeId);
  Future<void> updateRecipeFavouriteStatus(bool isFavourite, int recipeId);
  Future<void> updateRecipeCookedStatus(bool isFavourite, int recipeId);
  Future<List<RecipeCardInfoModel>> getFavouriteRecipes();
  Future<List<RecipeCardInfoModel>> getCookedRecipes();
  Future<List<RecipeCardInfoModel>> searchRecipesByName(
    String query,
    String levels,
    String categories,
    String ingredients,
  );
  Future<List<RecipeCardInfoModel>> searchRecipesByAnimeTitle(
    String query,
    String levels,
    String categories,
    String ingredients,
  );
  Future<List<IngredientModel>> getIngredients();
}

class RecipeLocalDataSourceImpl implements RecipeLocalDataSource {
  Database db;
  RecipeLocalDataSourceImpl({required this.db});
  @override
  Future<RecipeModel> getRecipeById(int id) async {
    final maps = await db.query(
      'recipes',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return RecipeModel.fromMap(maps.first);
    } else {
      throw Exception('Recipe with id $id not found');
    }
  }

  @override
  Future<CategoryModel> getCategory(int id) async {
    final maps = await db.query(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isEmpty) throw Exception('Category with id $id not found');
    return CategoryModel.fromMap(maps.first);
  }

  @override
  Future<List<AnimeModel>> getAnimesByRecipe(int recipeId) async {
    final maps = await db.rawQuery(
      '''
      SELECT a.* FROM animes a
      INNER JOIN recipes_in_anime ra ON a.id = ra.anime_id
      WHERE ra.recipe_id = ?
    ''',
      [recipeId],
    );

    return maps.map((m) => AnimeModel.fromMap(m)).toList();
  }

  @override
  Future<List<IngredientGroupModel>> getIngredientGroups(int recipeId) async {
    final maps = await db.query(
      'ingredient_groups',
      where: 'recipe_id = ?',
      orderBy: 'order_index ASC',
      whereArgs: [recipeId],
    );
    return maps.map((m) => IngredientGroupModel.fromMap(m)).toList();
  }

  @override
  Future<List<IngredientInRecipeModel>> getIngredientsInRecipe(
    int recipeId,
  ) async {
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      '''
    SELECT 
      ir.id, 
      ir.group_id, 
      ir.ingredient_id, 
      ir.display_name, 
      ir.quantity, 
      ir.unit, 
      ir.note
    FROM ingredients_in_recipe ir
    INNER JOIN ingredient_groups ig ON ir.group_id = ig.id
    WHERE ig.recipe_id = ?
  ''',
      [recipeId],
    );

    return maps.map((m) => IngredientInRecipeModel.fromMap(m)).toList();
  }

  @override
  Future<List<RecipeSection>> getRecipeSections(int recipeId) async {
    final maps = await db.query(
      'recipe_sections',
      where: 'recipe_id = ?',
      orderBy: 'order_index ASC',
      whereArgs: [recipeId],
    );
    return maps.map((m) => RecipeSection.fromMap(m)).toList();
  }

  @override
  Future<List<Step>> getSteps(int recipeId) async {
    final maps = await db.rawQuery(
      '''
      SELECT s.* FROM steps s
      INNER JOIN recipe_sections rs ON s.section_id = rs.id
      WHERE rs.recipe_id = ?
      ORDER BY s.order_index ASC
    ''',
      [recipeId],
    );

    return maps.map((m) => Step.fromMap(m)).toList();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final maps = await db.query('categories');
    return maps.map((m) => CategoryModel.fromMap(m)).toList();
  }

  @override
  Future<List<RecipeCardInfoModel>> getRecipesByCategory(
    String category,
  ) async {
    final maps = await db.rawQuery(
      '''
      SELECT r.id, r.name, r.cooking_time, r.image_url, a.title as title FROM recipes r
      INNER JOIN categories c ON r.category_id = c.id 
	  INNER JOIN recipes_in_anime ra ON r.id = ra.recipe_id 
	  INNER JOIN animes a ON ra.anime_id = a.id
      WHERE c.name = ?
      ''',
      [category],
    );

    return maps.map((m) => RecipeCardInfoModel.fromMap(m)).toList();
  }

  @override
  Future<void> updateRecipeFavouriteStatus(
    bool isFavourite,
    int recipeId,
  ) async {
    await db.update(
      'recipes',
      {'is_favourite': isFavourite ? 1 : 0},
      where: 'id = ?',
      whereArgs: [recipeId],
    );
  }

  @override
  Future<void> updateRecipeCookedStatus(bool isCooked, int recipeId) async {
    await db.update(
      'recipes',
      {'is_cooked': isCooked ? 1 : 0},
      where: 'id = ?',
      whereArgs: [recipeId],
    );
  }

  @override
  Future<List<RecipeCardInfoModel>> getFavouriteRecipes() async {
    final maps = await db.rawQuery('''
     SELECT r.id, r.name, r.cooking_time, r.image_url, a.title as title FROM recipes r
      INNER JOIN categories c ON r.category_id = c.id 
	  INNER JOIN recipes_in_anime ra ON r.id = ra.recipe_id 
	  INNER JOIN animes a ON ra.anime_id = a.id
      where is_favourite = 1
      ''');

    return maps.map((m) => RecipeCardInfoModel.fromMap(m)).toList();
  }

  @override
  Future<List<RecipeCardInfoModel>> getCookedRecipes() async {
    final maps = await db.rawQuery('''
     SELECT r.id, r.name, r.cooking_time, r.image_url, a.title as title FROM recipes r
      INNER JOIN categories c ON r.category_id = c.id 
	  INNER JOIN recipes_in_anime ra ON r.id = ra.recipe_id 
	  INNER JOIN animes a ON ra.anime_id = a.id
      where is_cooked = 1
      ''');

    return maps.map((m) => RecipeCardInfoModel.fromMap(m)).toList();
  }

  @override
  Future<List<RecipeCardInfoModel>> searchRecipesByAnimeTitle(
      String query,
      String levels,
      String categories,
      String ingredients,
      ) async {
    String matchCountSql = ingredients.isNotEmpty
        ? '''(
          SELECT COUNT(DISTINCT iir.ingredient_id)
          FROM ingredient_groups ig
          JOIN ingredients_in_recipe iir ON ig.id = iir.group_id
          WHERE ig.recipe_id = r.id
            AND iir.ingredient_id IN ($ingredients)
        )'''
        : '0';

    String sql = '''
    SELECT r.id, r.name, r.cooking_time, r.image_url, a.title as title,
           $matchCountSql as match_count
    FROM recipes r
    JOIN recipes_in_anime ria ON r.id = ria.recipe_id
    JOIN animes a ON ria.anime_id = a.id
    WHERE a.title LIKE ? 
  ''';
    final List<dynamic> args = ['%$query%'];

    if (levels.isNotEmpty) {
      sql += ' AND r.level IN ($levels)';
    }

    if (categories.isNotEmpty) {
      sql +=
      ' AND r.category_id IN (SELECT id FROM categories WHERE name IN ($categories))';
    }

    if (ingredients.isNotEmpty) {
      sql += ' AND match_count > 0';
    }

    sql += ' ORDER BY match_count DESC';

    final maps = await db.rawQuery(sql, args);
    return maps.map((m) => RecipeCardInfoModel.fromMap(m)).toList();
  }


  @override
  Future<List<RecipeCardInfoModel>> searchRecipesByName(
      String query,
      String levels,
      String categories,
      String ingredients,
      ) async {
    String matchCountSql = ingredients.isNotEmpty
        ? '''(
          SELECT COUNT(DISTINCT iir.ingredient_id)
          FROM ingredient_groups ig
          JOIN ingredients_in_recipe iir ON ig.id = iir.group_id
          WHERE ig.recipe_id = r.id
            AND iir.ingredient_id IN ($ingredients)
        )'''
        : '0';

    String sql = '''
    SELECT 
      r.id, 
      r.name, 
      r.cooking_time, 
      r.image_url, 
      a.title AS title,
      $matchCountSql AS match_count
    FROM recipes r   
    JOIN recipes_in_anime ria ON r.id = ria.recipe_id
    JOIN animes a ON ria.anime_id = a.id 
    WHERE r.name LIKE ?
  ''';

    final List<dynamic> args = ['%$query%'];

    if (levels.isNotEmpty) {
      sql += ' AND r.level IN ($levels)';
    }

    if (categories.isNotEmpty) {
      sql +=
      ' AND r.category_id IN (SELECT id FROM categories WHERE name IN ($categories))';
    }

    if (ingredients.isNotEmpty) {
      sql += ' AND match_count > 0';
    }

    sql += ' ORDER BY match_count DESC';

    final maps = await db.rawQuery(sql, args);

    return maps.map((m) => RecipeCardInfoModel.fromMap(m)).toList();
  }


  @override
  Future<int> getRecipesAmount() async {
    final result = await db.rawQuery('''
    SELECT COUNT(*) FROM recipes 
    ''');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  @override
  Future<List<IngredientModel>> getIngredients() async {
    final maps = await db.query(
      'ingredients',
      orderBy: 'name COLLATE NOCASE ASC',
    );
    return maps.map((m) => IngredientModel.fromMap(m)).skip(1).toList();
  }
}
