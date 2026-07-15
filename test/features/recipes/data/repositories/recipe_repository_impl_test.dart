import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:otakukitchen/features/recipes/data/mappers/ingredient_mapper.dart';
import 'package:otakukitchen/features/recipes/data/mappers/recipe_section_mapper.dart';
import 'package:otakukitchen/features/recipes/data/models/anime_model.dart';
import 'package:otakukitchen/features/recipes/data/models/category_model.dart';
import 'package:otakukitchen/features/recipes/data/models/ingredient_group_model.dart';
import 'package:otakukitchen/features/recipes/data/models/ingredient_in_recipe_model.dart';
import 'package:otakukitchen/features/recipes/data/models/recipe_card_info_model.dart';
import 'package:otakukitchen/features/recipes/data/models/recipe_model.dart';
import 'package:otakukitchen/features/recipes/data/models/recipe_section_model.dart';
import 'package:otakukitchen/features/recipes/data/models/step_model.dart';

import 'package:otakukitchen/features/recipes/data/repositories/recipe_repository_impl.dart';
import 'package:otakukitchen/features/recipes/data/sources/recipe_local_datasource.dart';

class MockRecipeLocalDataSource extends Mock implements RecipeLocalDataSource {}

void main() {
  late RecipeRepositoryImpl repository;
  late MockRecipeLocalDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockRecipeLocalDataSource();
    repository = RecipeRepositoryImpl(mockDataSource);
  });

  const recipeId = 1;

  test('should return fully mapped RecipeEntity', () async {
    // arrange
    when(() => mockDataSource.getRecipeById(recipeId)).thenAnswer(
      (_) async => RecipeModel(
        id: 1,
        name: 'Ramen',
        cookingTime: '30 min',
        level: 'easy',
        categoryId: 10,
        imageUrl: 'img',
        isFavourite: true,
        isCooked: false,
      ),
    );

    when(
      () => mockDataSource.getCategory(10),
    ).thenAnswer((_) async => CategoryModel(id: 10, name: 'Main', icon: '🍜'));

    when(() => mockDataSource.getAnimesByRecipe(recipeId)).thenAnswer(
      (_) async => [
        AnimeModel(
          id: 1,
          title: 'Naruto',
          sceneDescription: 'Ramen scene',
          episode: "5",
        ),
      ],
    );

    when(() => mockDataSource.getIngredientGroups(recipeId)).thenAnswer(
      (_) async => [
        IngredientGroupModel(
          id: 1,
          recipeId: 1,
          title: 'Group 1',
          orderIndex: 0,
        ),
      ],
    );

    when(() => mockDataSource.getIngredientsInRecipe(recipeId)).thenAnswer(
      (_) async => [
        IngredientInRecipeModel(
          id: 1,
          groupId: 1,
          ingredientId: 1,
          displayName: 'Salt',
          quantity: '10',
          unit: 'g',
        ),
      ],
    );

    when(() => mockDataSource.getRecipeSections(recipeId)).thenAnswer(
      (_) async => [
        RecipeSection(id: 1, recipeId: 1, title: 'Section 1', orderIndex: 0),
      ],
    );

    when(() => mockDataSource.getSteps(recipeId)).thenAnswer(
      (_) async => [
        Step(id: 1, sectionId: 1, orderIndex: 0, description: 'Step 1'),
      ],
    );

    // act
    final result = await repository.getRecipeDetails(recipeId);

    // assert basic fields
    expect(result.id, 1);
    expect(result.name, 'Ramen');
    expect(result.category.name, 'Main');

    // assert animes
    expect(result.animes.length, 1);
    expect(result.animes.first.title, 'Naruto');

    // assert ingredient groups
    expect(result.ingredientGroups.length, 1);
    expect(result.ingredientGroups.first.ingredients.first.name, 'Salt');
    expect(result.ingredientGroups.first.ingredients.first.amount, '10 g');

    // assert sections and steps
    expect(result.sections.length, 1);
    expect(result.sections.first.title, 'Section 1');
    expect(result.sections.first.steps.first.description, 'Step 1');
  });

  test('should set "по вкусу" when quantity and unit are null', () async {
    when(() => mockDataSource.getRecipeById(recipeId)).thenAnswer(
      (_) async => RecipeModel(
        id: 1,
        name: 'Ramen',
        cookingTime: '30 min',
        level: 'easy',
        categoryId: 1,
        imageUrl: '',
        isFavourite: false,
        isCooked: false,
      ),
    );

    when(
      () => mockDataSource.getCategory(1),
    ).thenAnswer((_) async => CategoryModel(id: 1, name: '', icon: ''));

    when(
      () => mockDataSource.getAnimesByRecipe(recipeId),
    ).thenAnswer((_) async => []);

    when(() => mockDataSource.getIngredientGroups(recipeId)).thenAnswer(
      (_) async => [
        IngredientGroupModel(
          id: 1,
          recipeId: recipeId,
          title: 'Test',
          orderIndex: 0,
        ),
      ],
    );

    when(() => mockDataSource.getIngredientsInRecipe(recipeId)).thenAnswer(
      (_) async => [
        IngredientInRecipeModel(
          id: 1,
          groupId: 1,
          ingredientId: 1,
          displayName: 'Salt',
          quantity: null,
          unit: null,
        ),
      ],
    );

    when(
      () => mockDataSource.getRecipeSections(recipeId),
    ).thenAnswer((_) async => []);

    when(() => mockDataSource.getSteps(recipeId)).thenAnswer((_) async => []);

    final result = await repository.getRecipeDetails(recipeId);

    expect(result.ingredientGroups.first.ingredients.first.amount, 'по вкусу');
  });

  test('should map ingredient groups correctly', () {
    final groups = [
      IngredientGroupModel(id: 1, recipeId: 1, title: 'Group', orderIndex: 0),
    ];

    final items = [
      IngredientInRecipeModel(
        id: 1,
        groupId: 1,
        ingredientId: 1,
        displayName: 'Salt',
        quantity: '100',
        unit: 'g',
        note: '',
      ),
    ];

    final result = IngredientMapper.mapGroups(groups, items);

    expect(result.first.ingredients.first.amount, '100 g');
  });

  test('should sort sections and steps correctly', () {
    final sections = [
      RecipeSection(id: 1, recipeId: 1, title: 'Second Section', orderIndex: 2),
      RecipeSection(id: 2, recipeId: 1, title: 'First Section', orderIndex: 1),
    ];

    final steps = [
      Step(
        id: 1,
        sectionId: 2,
        orderIndex: 2,
        description: 'Step 2 in Section 2',
      ),
      Step(
        id: 2,
        sectionId: 2,
        orderIndex: 1,
        description: 'Step 1 in Section 2',
      ),
      Step(
        id: 3,
        sectionId: 1,
        orderIndex: 1,
        description: 'Step in Section 1',
      ),
    ];
    final result = RecipeSectionMapper.mapSections(sections, steps);

    expect(result.last.title, 'Second Section');
    expect(result.first.steps.first.stepNumber, 1);
  });

  group('getCategories', () {
    final tCategoryModels = [
      CategoryModel(id: 1, name: 'Main', icon: '🍜'),
      CategoryModel(id: 2, name: 'Desserts', icon: '🍰'),
    ];

    test(
      'should return list of CategoryEntity when call is successful',
      () async {
        // arrange
        when(
          () => mockDataSource.getCategories(),
        ).thenAnswer((_) async => tCategoryModels);

        // act
        final result = await repository.getCategories();

        // assert
        expect(result.length, 2);
        expect(result[0].id, 1);
        expect(result[0].name, 'Main');
        expect(result[1].icon, '🍰');
        verify(() => mockDataSource.getCategories()).called(1);
      },
    );

    test('should throw exception when datasource fails', () async {
      // arrange
      when(() => mockDataSource.getCategories()).thenThrow(Exception());

      // act
      final call = repository.getCategories;

      // assert
      expect(() => call(), throwsA(isA<Exception>()));
      verify(() => mockDataSource.getCategories()).called(1);
    });
  });
  group('getRecipesByCategory', () {
    const tCategory = 'Main';

    final tRecipeModels = [
      RecipeCardInfoModel(
        id: 1,
        name: 'Ramen',
        cookingTime: '30m',
        imageUrl: '',
        animeTitle: 'Naruto',
      ),
      RecipeCardInfoModel(
        id: 2,
        name: 'Sushi',
        cookingTime: '40m',
        imageUrl: '',
        animeTitle: 'Naruto',
      ),
    ];

    test(
      'should fetch recipes',
      () async {
        // arrange
        when(
          () => mockDataSource.getRecipesByCategory(tCategory),
        ).thenAnswer((_) async => tRecipeModels);

        when(
          () => mockDataSource.getCategory(any()),
        ).thenAnswer((_) async => CategoryModel(id: 1, name: 'Main', icon: ''));
        when(
          () => mockDataSource.getAnimesByRecipe(any()),
        ).thenAnswer((_) async => []);
        when(
          () => mockDataSource.getIngredientGroups(any()),
        ).thenAnswer((_) async => []);
        when(
          () => mockDataSource.getIngredientsInRecipe(any()),
        ).thenAnswer((_) async => []);
        when(
          () => mockDataSource.getRecipeSections(any()),
        ).thenAnswer((_) async => []);
        when(() => mockDataSource.getSteps(any())).thenAnswer((_) async => []);

        // act
        final result = await repository.getRecipesByCategory(tCategory);

        // assert
        expect(result.length, 2);
        expect(result[0].id, 1);
        expect(result[1].id, 2);

        verify(() => mockDataSource.getRecipesByCategory(tCategory)).called(1);
      },
    );
  });
  group('updateRecipeFavouriteStatus', () {
    const tRecipeId = 1;
    const tIsFavourite = true;

    test(
      'should call dataSource.updateRecipeFavouriteStatus with correct parameters',
      () async {
        // arrange
        when(
          () => mockDataSource.updateRecipeFavouriteStatus(any(), any()),
        ).thenAnswer((_) async => Future.value());

        // act
        await repository.updateRecipeFavouriteStatus(tIsFavourite, tRecipeId);

        // assert
        verify(
          () => mockDataSource.updateRecipeFavouriteStatus(
            tIsFavourite,
            tRecipeId,
          ),
        ).called(1);
      },
    );

    test('should throw exception when dataSource fails', () async {
      // arrange
      when(
        () => mockDataSource.updateRecipeFavouriteStatus(any(), any()),
      ).thenThrow(Exception('DB Update Error'));

      // act
      final call = repository.updateRecipeFavouriteStatus;

      // assert
      expect(() => call(tIsFavourite, tRecipeId), throwsA(isA<Exception>()));
      verify(
        () =>
            mockDataSource.updateRecipeFavouriteStatus(tIsFavourite, tRecipeId),
      ).called(1);
    });
  });
  group('updateRecipeCookedStatus', () {
    const tRecipeId = 1;
    const tIsCooked = true;

    test(
      'should call dataSource.updateRecipeCookedStatus with correct parameters',
      () async {
        // arrange
        when(
          () => mockDataSource.updateRecipeCookedStatus(any(), any()),
        ).thenAnswer((_) async => Future.value());

        // act
        await repository.updateRecipeCookedStatus(tIsCooked, tRecipeId);

        // assert
        verify(
          () => mockDataSource.updateRecipeCookedStatus(tIsCooked, tRecipeId),
        ).called(1);
      },
    );

    test('should throw exception when dataSource fails', () async {
      // arrange
      when(
        () => mockDataSource.updateRecipeCookedStatus(any(), any()),
      ).thenThrow(Exception('DB Update Error'));

      // act
      final call = repository.updateRecipeCookedStatus;

      // assert
      expect(() => call(tIsCooked, tRecipeId), throwsA(isA<Exception>()));
      verify(
        () => mockDataSource.updateRecipeCookedStatus(tIsCooked, tRecipeId),
      ).called(1);
    });
  });

  group('Search Methods', () {
    const tQuery = 'Naruto';
    const tLevels = "'easy'";
    const tCategories = "'main'";

    final tRecipeModels = [
      RecipeModel(
        id: 1,
        name: 'Ramen',
        categoryId: 1,
        cookingTime: '',
        level: '',
        imageUrl: '',
        isFavourite: false,
        isCooked: false,
      ),
      RecipeModel(
        id: 2,
        name: 'Soup',
        categoryId: 1,
        cookingTime: '',
        level: '',
        imageUrl: '',
        isFavourite: false,
        isCooked: false,
      ),
    ];

    void mockRecipeDetails(int id, String name) {
      when(() => mockDataSource.getRecipeById(id)).thenAnswer(
        (_) async => RecipeModel(
          id: id,
          name: name,
          categoryId: 1,
          cookingTime: '',
          level: '',
          imageUrl: '',
          isFavourite: false,
          isCooked: false,
        ),
      );
      when(
        () => mockDataSource.getCategory(any()),
      ).thenAnswer((_) async => CategoryModel(id: 1, name: '', icon: ''));
      when(
        () => mockDataSource.getAnimesByRecipe(id),
      ).thenAnswer((_) async => []);
      when(
        () => mockDataSource.getIngredientGroups(id),
      ).thenAnswer((_) async => []);
      when(
        () => mockDataSource.getIngredientsInRecipe(id),
      ).thenAnswer((_) async => []);
      when(
        () => mockDataSource.getRecipeSections(id),
      ).thenAnswer((_) async => []);
      when(() => mockDataSource.getSteps(id)).thenAnswer((_) async => []);
    }
  });
  group('getRecipesAmount', () {
    test(
      'should return the total number of recipes from the data source upon a successful request',
      () async {
        // Arrange
        when(
          () => mockDataSource.getRecipesAmount(),
        ).thenAnswer((_) async => 42);

        // Act
        final result = await repository.getRecipesAmount();

        // Assert
        expect(result, equals(42));
        verify(() => mockDataSource.getRecipesAmount()).called(1);
        verifyNoMoreInteractions(mockDataSource);
      },
    );

    test(
      'should rethrow the error if the data source throws an exception',
      () async {
        // Arrange
        when(
          () => mockDataSource.getRecipesAmount(),
        ).thenThrow(Exception('DB Error'));

        // Act & Assert
        expect(() => repository.getRecipesAmount(), throwsA(isA<Exception>()));
      },
    );
  });
}
