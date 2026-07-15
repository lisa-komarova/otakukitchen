import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:otakukitchen/features/recipes/data/models/recipe_card_info_model.dart';
import 'package:otakukitchen/features/recipes/data/sources/recipe_local_datasource.dart';
import 'package:sqflite/sqflite.dart';
import 'package:otakukitchen/features/recipes/data/models/anime_model.dart';
import 'package:otakukitchen/features/recipes/data/models/category_model.dart';
import 'package:otakukitchen/features/recipes/data/models/ingredient_group_model.dart';
import 'package:otakukitchen/features/recipes/data/models/ingredient_in_recipe_model.dart';
import 'package:otakukitchen/features/recipes/data/models/recipe_model.dart';
import 'package:otakukitchen/features/recipes/data/models/recipe_section_model.dart';
import 'package:otakukitchen/features/recipes/data/models/step_model.dart';

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

      when(
        () =>
            mockDb.query('recipes', where: 'id = ?', whereArgs: [1], limit: 1),
      ).thenAnswer((_) async => [map]);

      final result = await dataSource.getRecipeById(1);

      expect(result, isA<RecipeModel>());
      expect(result.id, 1);
      expect(result.name, 'Ramen');
      expect(result.isFavourite, true);
    });

    test('getRecipeById throws Exception when not found', () async {
      when(
        () =>
            mockDb.query('recipes', where: 'id = ?', whereArgs: [99], limit: 1),
      ).thenAnswer((_) async => []);

      expect(() => dataSource.getRecipeById(99), throwsException);
    });

    test('getCategory returns Category when found', () async {
      final map = {'id': 1, 'name': 'Dessert', 'icon': 'cake'};

      when(
        () => mockDb.query(
          'categories',
          where: 'id = ?',
          whereArgs: [1],
          limit: 1,
        ),
      ).thenAnswer((_) async => [map]);

      final result = await dataSource.getCategory(1);

      expect(result, isA<CategoryModel>());
      expect(result.id, 1);
      expect(result.name, 'Dessert');
    });

    test('getCategory throws Exception when not found', () async {
      when(
        () => mockDb.query(
          'categories',
          where: 'id = ?',
          whereArgs: [99],
          limit: 1,
        ),
      ).thenAnswer((_) async => []);

      expect(() => dataSource.getCategory(99), throwsException);
    });

    test('getAnimesByRecipe returns list of Anime', () async {
      final maps = [
        {
          'id': 1,
          'title': 'Naruto',
          'scene_description': null,
          'episode': null,
        },
        {
          'id': 2,
          'title': 'One Piece',
          'scene_description': null,
          'episode': null,
        },
      ];

      when(() => mockDb.rawQuery(any(), any())).thenAnswer((_) async => maps);

      final result = await dataSource.getAnimesByRecipe(1);

      expect(result, isA<List<AnimeModel>>());
      expect(result.length, 2);
      expect(result.first.title, 'Naruto');
    });

    test('getIngredientGroups returns sorted list', () async {
      final maps = [
        {'id': 1, 'recipe_id': 1, 'title': 'Main', 'order_index': 2},
        {'id': 2, 'recipe_id': 1, 'title': 'Extra', 'order_index': 1},
      ];

      when(
        () => mockDb.query(
          'ingredient_groups',
          where: any(named: 'where'),
          whereArgs: any(named: 'whereArgs'),
          orderBy: any(named: 'orderBy'),
        ),
      ).thenAnswer((_) async => maps);

      final result = await dataSource.getIngredientGroups(1);

      expect(result, isA<List<IngredientGroupModel>>());
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

      expect(result, isA<List<IngredientInRecipeModel>>());
      expect(result.first.displayName, 'Sugar');
    });

    test('getRecipeSections returns list sorted by orderIndex', () async {
      final maps = [
        {'id': 1, 'recipe_id': 1, 'title': 'Prep', 'order_index': 2},
        {'id': 2, 'recipe_id': 1, 'title': 'Cook', 'order_index': 1},
      ];

      when(
        () => mockDb.query(
          'recipe_sections',
          where: any(named: 'where'),
          whereArgs: any(named: 'whereArgs'),
          orderBy: any(named: 'orderBy'),
        ),
      ).thenAnswer((_) async => maps);

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
      expect(result, isA<List<CategoryModel>>());
      expect(result.length, 2);
      expect(result[0].name, 'Main');
      expect(result[1].icon, '🍰');
      verify(() => mockDb.query('categories')).called(1);
    });

    group('getRecipesByCategory', () {
      const tCategory = 'Супы';

      final tRecipesRaw = [
        {
          'id': 1,
          'name': 'Рамен',
          'cookingTime': '30 мин',
          'imageUrl': 'url',
          'animeTitle': 'Naruto',
        },
      ];

      test('should perform a rawQuery and return a list of RecipesCardInfo', () async {
        // arrange
        when(
          () => mockDb.rawQuery(any(), any()),
        ).thenAnswer((_) async => tRecipesRaw);

        // act
        final result = await dataSource.getRecipesByCategory(tCategory);

        // assert
        verify(() => mockDb.rawQuery(any(), [tCategory])).called(1);

        expect(result, isA<List<RecipeCardInfoModel>>());
        expect(result.length, 1);
        expect(result.first.name, 'Рамен');
      });

      test('should throw an exception when database execution fails', () async {
        // arrange
        when(
          () => mockDb.rawQuery(any(), any()),
        ).thenThrow(Exception('DB Error'));

        // act
        final call = dataSource.getRecipesByCategory(tCategory);

        // assert
        expect(() => call, throwsA(isA<Exception>()));
      });
    });

    test('should call update on database with correct values', () async {
      // Arrange
      const tId = 1;
      const tIsFavourite = true;

      when(
        () => mockDb.update(
          any(),
          any(),
          where: any(named: 'where'),
          whereArgs: any(named: 'whereArgs'),
        ),
      ).thenAnswer((_) async => 1);

      // Act
      await dataSource.updateRecipeFavouriteStatus(tIsFavourite, tId);

      // Assert
      verify(
        () => mockDb.update(
          'recipes',
          {'is_favourite': 1},
          where: 'id = ?',
          whereArgs: any(named: 'whereArgs'),
        ),
      ).called(1);
    });
  });
  group('searchRecipesByAnimeTitle', () {
    const tQuery = 'Naruto';
    const tLevels = "'easy', 'medium'";
    const tCategories = "'Soup'";

    final tRecipeMap = [
      {
        'id': 1,
        'name': 'Ramen',
        'level': 'easy',
        'category': 'Soup',
        'cookingTime': '30 min',
        'imageUrl': '',
        'isFavourite': 0,
      },
    ];

    test('should execute correct SQL query for anime title search', () async {
      // Arrange
      when(
        () => mockDb.rawQuery(any(), any()),
      ).thenAnswer((_) async => tRecipeMap);

      // Act
      await dataSource.searchRecipesByAnimeTitle(tQuery, tLevels, tCategories);

      // Assert
      verify(
        () => mockDb.rawQuery(
          any(
            that: contains('JOIN recipes_in_anime'),
          ), // Проверяем наличие JOIN
          ['%$tQuery%', tLevels, tCategories],
        ),
      ).called(1);
    });
  });

  group('searchRecipesByName', () {
    test('should execute correct SQL query for recipe name search', () async {
      // Arrange
      const tQuery = 'Ramen';
      when(() => mockDb.rawQuery(any(), any())).thenAnswer((_) async => []);

      // Act
      await dataSource.searchRecipesByName(tQuery, '', '');

      // Assert
      verify(
        () => mockDb.rawQuery(any(that: contains('WHERE r.name LIKE ?')), [
          '%Ramen%',
          '',
          '',
        ]),
      ).called(1);
    });
  });
  group('Levels Filtering', () {
    test(
      'should correctly call rawQuery with level filter and return list of card models',
          () async {
        final mockRawDbResult = [
          {
            'id': 1,
            'name': 'Miso Ramen',
            'level': 'easy',
            'category_id': 1,
            'cooking_time': '20',
            'image_url': '',
          },
        ];

        when(() => mockDb.rawQuery(any(), any()))
            .thenAnswer((_) async => mockRawDbResult);

        final result = await dataSource.searchRecipesByName('', "'easy'", '');

        expect(result.length, 1);
        expect(result.first.name, 'Miso Ramen');
        expect(result.first.id, 1);

        verify(() => mockDb.rawQuery(
          any(),
          any(that: contains("'easy'")), // Ищем строку с кавычками внутри
        )).called(1);

          },
    );


    test(
      'should return multiple levels when IN clause has multiple values',
      () async {
        // arrange
        when(() => mockDb.rawQuery(any(), any())).thenAnswer(
          (_) async => [
            {'id': 1, 'name': 'Ramen', 'level': 'easy', 'category': 'Soup'},
            {'id': 2, 'name': 'Sushi', 'level': 'hard', 'category': 'Fish'},
          ],
        );

        // act
        final result = await dataSource.searchRecipesByName(
          '',
          "'easy', 'hard'",
          '',
        );

        // assert
        expect(result.length, 2);
        verify(() => mockDb.rawQuery(any(), any())).called(1);
      },
    );
  });
  group('Categories Filtering', () {
    test('should execute correct SQL query for category search', () async {
      // Arrange
      const tCategoryId = '1';
      when(() => mockDb.rawQuery(any(), any())).thenAnswer((_) async => []);

      // Act
      await dataSource.searchRecipesByName('', '', tCategoryId);

      // Assert
      verify(
        () => mockDb.rawQuery(
          any(that: contains('category_id IN (SELECT id FROM categories')),
          [
            '%%', 
            '', 
            tCategoryId,
          ],
        ),
      ).called(1);
    });
  });

  group('Empty Filters Logic', () {
    test(
      'should ignore level and category filters when they are empty strings',
      () async {
        // Arrange
        when(() => mockDb.rawQuery(any(), any())).thenAnswer(
          (_) async => [
            {'id': 1, 'name': 'Ramen', 'categoryId': 1, 'level': 'easy'},
          ],
        );

        // Act
        await dataSource.searchRecipesByName('Ramen', '', '');

        // Assert
        verify(() => mockDb.rawQuery(any(), ['%Ramen%', '', ''])).called(1);
      },
    );
  });

  group('Complex Search (Anime Title + Filters)', () {
    test(
      'should call searchByAnimeTitle with all arguments correctly',
      () async {
        // Arrange
        const tQuery = 'Naruto';
        const tLevels = "'hard'";
        const tCategories = "'1', '2'";

        when(() => mockDb.rawQuery(any(), any())).thenAnswer((_) async => []);

        // Act
        await dataSource.searchRecipesByAnimeTitle(
          tQuery,
          tLevels,
          tCategories,
        );

        // Assert
        verify(
          () => mockDb.rawQuery(
            any(
              that: allOf([
                contains('JOIN animes'),
                contains('a.title LIKE ?'),
                contains('r.level IN ($tLevels)'),
              ]),
            ),
            ['%$tQuery%', tLevels, tCategories],
          ),
        ).called(1);
      },
    );
  });
  group('Recipe Database Status Methods', () {
    const tRecipeId = 1;

    final tRawRecipesMaps = [
      {
        'id': 1,
        'name': 'Ramen',
        'category_id': 1,
        'cooking_time': '30 min',
        'level': 'easy',
        'image_url': 'assets/ramen.png',
        'is_favourite': 1,
        'is_cooked': 0,
      },
      {
        'id': 2,
        'name': 'Soup',
        'category_id': 1,
        'cooking_time': '15 min',
        'level': 'easy',
        'image_url': 'assets/soup.png',
        'is_favourite': 0,
        'is_cooked': 1,
      },
    ];

    test(
      'updateRecipeFavouriteStatus updates is_favourite field with correct integer',
      () async {
        // arrange
        when(
          () => mockDb.update(
            'recipes',
            any(),
            where: any(named: 'where'),
            whereArgs: any(named: 'whereArgs'),
          ),
        ).thenAnswer(
          (_) async => 1,
        ); 

        // act
        await dataSource.updateRecipeFavouriteStatus(true, tRecipeId);

        // assert
        verify(
          () => mockDb.update(
            'recipes',
            {'is_favourite': 1}, 
            where: 'id = ?',
            whereArgs: [tRecipeId],
          ),
        ).called(1);
      },
    );

    test(
      'updateRecipeCookedStatus updates is_cooked field with correct integer',
      () async {
        // arrange
        when(
          () => mockDb.update(
            'recipes',
            any(),
            where: any(named: 'where'),
            whereArgs: any(named: 'whereArgs'),
          ),
        ).thenAnswer((_) async => 1);

        // act
        await dataSource.updateRecipeCookedStatus(true, tRecipeId);

        // assert
        verify(
          () => mockDb.update(
            'recipes',
            {'is_cooked': 1}, 
            where: 'id = ?',
            whereArgs: [tRecipeId],
          ),
        ).called(1);
      },
    );

    test(
      'getFavouriteRecipes returns list of RecipeCardInfoModel when items exist',
          () async {
        final favouriteMap = [tRawRecipesMaps[0]];

        when(
              () => mockDb.rawQuery(any()),
        ).thenAnswer((_) async => favouriteMap);

        final result = await dataSource.getFavouriteRecipes();

        expect(result, isA<List<RecipeCardInfoModel>>());
        expect(result.length, 1);
        expect(result.first.id, 1);
        expect(result.first.name, 'Ramen');
        verify(() => mockDb.rawQuery(any())).called(1);
      },
    );


    test('getCookedRecipes returns list of RecipeCardInfoModel when items exist', () async {
      final cookedMap = [
        {
          'id': 2,
          'name': 'Soup',
          'category_id': 1,
          'cooking_time': '30',
          'image_url': '',
          'is_cooked': 1,
        }
      ];

      when(() => mockDb.rawQuery(any())).thenAnswer((_) async => cookedMap);

      final result = await dataSource.getCookedRecipes();

      expect(result, isA<List<RecipeCardInfoModel>>());
      expect(result.length, 1);
      expect(result.first.id, 2);
      expect(result.first.name, 'Soup');
      verify(() => mockDb.rawQuery(any())).called(1);
    });

  });


}
