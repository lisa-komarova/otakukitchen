import 'package:otakukitchen/features/recipes/data/models/anime_model.dart';
import 'package:otakukitchen/features/recipes/data/models/category_model.dart';
import 'package:otakukitchen/features/recipes/data/models/ingredient_group.dart';
import 'package:otakukitchen/features/recipes/data/models/ingredient_in_recipe.dart';
import 'package:otakukitchen/features/recipes/data/models/recipe_model.dart';
import 'package:otakukitchen/features/recipes/data/models/recipe_section.dart';
import 'package:otakukitchen/features/recipes/data/models/step.dart';
import 'package:sqflite/sqflite.dart';

abstract class RecipeLocalDataSource {
  Future<Recipe> getRecipeById(int id);
  Future<Category> getCategory(int id);
  Future<List<Category>> getCategories();
  Future<List<Anime>> getAnimesByRecipe(int recipeId);

  Future<List<IngredientGroup>> getIngredientGroups(int recipeId);
  Future<List<IngredientInRecipe>> getIngredientsInRecipe(int recipeId);

  Future<List<RecipeSection>> getRecipeSections(int recipeId);
  Future<List<Step>> getSteps(int recipeId);
}

class RecipeLocalDataSourceImpl implements RecipeLocalDataSource {
  Database db;
  RecipeLocalDataSourceImpl({required this.db});
  @override
  Future<Recipe> getRecipeById(int id) async {
    final maps = await db.query(
      'recipes',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return Recipe.fromMap(maps.first);
    } else {
      throw Exception('Recipe with id $id not found');
    }
  }

  @override
  Future<Category> getCategory(int id) async {
    final maps = await db.query(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isEmpty) throw Exception('Category with id $id not found');
    return Category.fromMap(maps.first);
  }

  @override
  Future<List<Anime>> getAnimesByRecipe(int recipeId) async {
    final maps = await db.rawQuery(
      '''
      SELECT a.* FROM animes a
      INNER JOIN recipes_in_anime ra ON a.id = ra.anime_id
      WHERE ra.recipe_id = ?
    ''',
      [recipeId],
    );

    return maps.map((m) => Anime.fromMap(m)).toList();
  }

  @override
  Future<List<IngredientGroup>> getIngredientGroups(int recipeId) async {
    final maps = await db.query(
      'ingredient_groups',
      where: 'recipe_id = ?',
      orderBy: 'order_index ASC',
      whereArgs: [recipeId],
    );
    return maps.map((m) => IngredientGroup.fromMap(m)).toList();
  }

  @override
  Future<List<IngredientInRecipe>> getIngredientsInRecipe(int recipeId) async {
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

    return maps.map((m) => IngredientInRecipe.fromMap(m)).toList();
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
  Future<List<Category>> getCategories() async {
    final maps = await db.query('categories');
    return maps.map((m) => Category.fromMap(m)).toList();
  }
}
