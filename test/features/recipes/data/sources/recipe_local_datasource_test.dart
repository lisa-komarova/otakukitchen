import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:otakukitchen/features/recipes/data/sources/recipe_local_datasource.dart';
import 'package:sqflite/sqflite.dart';
import 'package:otakukitchen/features/recipes/data/models/anime_model.dart';
import 'package:otakukitchen/features/recipes/data/models/category_model.dart';
import 'package:otakukitchen/features/recipes/data/models/ingredient_group.dart';
import 'package:otakukitchen/features/recipes/data/models/ingredient_in_recipe.dart';
import 'package:otakukitchen/features/recipes/data/models/recipe_model.dart';
import 'package:otakukitchen/features/recipes/data/models/recipe_section.dart';
import 'package:otakukitchen/features/recipes/data/models/step.dart';

class MockDatabase extends Mock implements Database {}

void main() {
  late MockDatabase mockDb;
  late RecipeLocalDataSourceImpl dataSource;

  setUpAll(() {
    registerFallbackValue(<String, dynamic>{});
  });

  setUp(() {
    mockDb = MockDatabase();
    dataSource = RecipeLocalDataSourceImpl(db: mockDb);
  });

  group('RecipeLocalDataSourceImpl', () {
    test('getRecipeById returns Recipe when found', () async {
      final map = {
        'id': 1,
        'name': 'Ramen',
        'cooking_time': '30 min',
        'level': 'Easy',
        'category_id': 2,
        'image_url': 'img.png',
        'is_favourite': 1,
      };

      when(() => mockDb.query(
            'recipes',
            where: 'id = ?',
            whereArgs: [1],
            limit: 1,
          )).thenAnswer((_) async => [map]);

      final result = await dataSource.getRecipeById(1);

      expect(result, isA<Recipe>());
      expect(result.id, 1);
      expect(result.name, 'Ramen');
      expect(result.isFavourite, true);
    });

    test('getRecipeById throws Exception when not found', () async {
      when(() => mockDb.query(
            'recipes',
            where: 'id = ?',
            whereArgs: [99],
            limit: 1,
          )).thenAnswer((_) async => []);

      expect(() => dataSource.getRecipeById(99), throwsException);
    });

    test('getCategory returns Category when found', () async {
      final map = {'id': 1, 'name': 'Dessert', 'icon': 'cake'};

      when(() => mockDb.query(
            'categories',
            where: 'id = ?',
            whereArgs: [1],
            limit: 1,
          )).thenAnswer((_) async => [map]);

      final result = await dataSource.getCategory(1);

      expect(result, isA<Category>());
      expect(result.id, 1);
      expect(result.name, 'Dessert');
    });

    test('getCategory throws Exception when not found', () async {
      when(() => mockDb.query(
            'categories',
            where: 'id = ?',
            whereArgs: [99],
            limit: 1,
          )).thenAnswer((_) async => []);

      expect(() => dataSource.getCategory(99), throwsException);
    });

    test('getAnimesByRecipe returns list of Anime', () async {
      final maps = [
        {'id': 1, 'title': 'Naruto', 'scene_description': null, 'episode': null},
        {'id': 2, 'title': 'One Piece', 'scene_description': null, 'episode': null},
      ];

      when(() => mockDb.rawQuery(any(), any())).thenAnswer((_) async => maps);

      final result = await dataSource.getAnimesByRecipe(1);

      expect(result, isA<List<Anime>>());
      expect(result.length, 2);
      expect(result.first.title, 'Naruto');
    });

    test('getIngredientGroups returns sorted list', () async {
      final maps = [
        {'id': 1, 'recipe_id': 1, 'title': 'Main', 'order_index': 2},
        {'id': 2, 'recipe_id': 1, 'title': 'Extra', 'order_index': 1},
      ];

      when(() => mockDb.query(
            'ingredient_groups',
            where: any(named: 'where'),
            whereArgs: any(named: 'whereArgs'),
            orderBy: any(named: 'orderBy'),
          )).thenAnswer((_) async => maps);

      final result = await dataSource.getIngredientGroups(1);

      expect(result, isA<List<IngredientGroup>>());
      expect(result.length, 2);
    });

    test('getIngredientsInRecipe returns list', () async {
      final maps = [
        {
          'id': 1,
          'group_id': 1,
          'ingredient_id': 10,
          'display_name': 'Sugar',
          'quantity': '2',
          'unit': 'tbsp',
          'note': null,
        },
      ];

      when(() => mockDb.rawQuery(any(), any())).thenAnswer((_) async => maps);

      final result = await dataSource.getIngredientsInRecipe(1);

      expect(result, isA<List<IngredientInRecipe>>());
      expect(result.first.displayName, 'Sugar');
    });

    test('getRecipeSections returns list sorted by orderIndex', () async {
      final maps = [
        {'id': 1, 'recipe_id': 1, 'title': 'Prep', 'order_index': 2},
        {'id': 2, 'recipe_id': 1, 'title': 'Cook', 'order_index': 1},
      ];

      when(() => mockDb.query(
            'recipe_sections',
            where: any(named: 'where'),
            whereArgs: any(named: 'whereArgs'),
            orderBy: any(named: 'orderBy'),
          )).thenAnswer((_) async => maps);

      final result = await dataSource.getRecipeSections(1);

      expect(result, isA<List<RecipeSection>>());
      expect(result.length, 2);
    });

    test('getSteps returns list sorted by orderIndex', () async {
      final maps = [
        {'id': 1, 'section_id': 1, 'description': 'Chop', 'order_index': 2},
        {'id': 2, 'section_id': 1, 'description': 'Cook', 'order_index': 1},
      ];

      when(() => mockDb.rawQuery(any(), any())).thenAnswer((_) async => maps);

      final result = await dataSource.getSteps(1);

      expect(result, isA<List<Step>>());
      expect(result.length, 2);
    });

        test('getCategories returns list of Category from database', () async {
      // arrange
      final maps = [
        {'id': 1, 'name': 'Main', 'icon': '🍜'},
        {'id': 2, 'name': 'Desserts', 'icon': '🍰'},
      ];

      when(() => mockDb.query('categories')).thenAnswer((_) async => maps);

      // act
      final result = await dataSource.getCategories();

      // assert
      expect(result, isA<List<Category>>());
      expect(result.length, 2);
      expect(result[0].name, 'Main');
      expect(result[1].icon, '🍰');
      verify(() => mockDb.query('categories')).called(1);
    });

  });
}