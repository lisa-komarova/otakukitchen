import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:otakukitchen/features/recipes/data/mappers/ingredient_mapper.dart';
import 'package:otakukitchen/features/recipes/data/mappers/recipe_section_mapper.dart';
import 'package:otakukitchen/features/recipes/data/models/anime_model.dart';
import 'package:otakukitchen/features/recipes/data/models/category_model.dart';
import 'package:otakukitchen/features/recipes/data/models/ingredient_group.dart';
import 'package:otakukitchen/features/recipes/data/models/ingredient_in_recipe.dart';
import 'package:otakukitchen/features/recipes/data/models/recipe_model.dart';
import 'package:otakukitchen/features/recipes/data/models/recipe_section.dart';
import 'package:otakukitchen/features/recipes/data/models/step.dart';

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
      (_) async => Recipe(
        id: 1,
        name: 'Ramen',
        cookingTime: '30 min',
        level: 'easy',
        categoryId: 10,
        imageUrl: 'img',
        isFavourite: true,
      ),
    );

    when(
      () => mockDataSource.getCategory(10),
    ).thenAnswer((_) async => Category(id: 10, name: 'Main', icon: '🍜'));

    when(() => mockDataSource.getAnimesByRecipe(recipeId)).thenAnswer(
      (_) async => [
        Anime(
          id: 1,
          title: 'Naruto',
          sceneDescription: 'Ramen scene',
          episode: "5",
        ),
      ],
    );

    when(() => mockDataSource.getIngredientGroups(recipeId)).thenAnswer(
      (_) async => [
        IngredientGroup(id: 1, recipeId: 1, title: 'Group 1', orderIndex: 0),
      ],
    );

    when(() => mockDataSource.getIngredientsInRecipe(recipeId)).thenAnswer(
      (_) async => [
        IngredientInRecipe(
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
      (_) async => Recipe(
        id: 1,
        name: 'Ramen',
        cookingTime: '30 min',
        level: 'easy',
        categoryId: 1,
        imageUrl: '',
        isFavourite: false,
      ),
    );

    when(
      () => mockDataSource.getCategory(1),
    ).thenAnswer((_) async => Category(id: 1, name: '', icon: ''));

    when(
      () => mockDataSource.getAnimesByRecipe(recipeId),
    ).thenAnswer((_) async => []);

    when(() => mockDataSource.getIngredientGroups(recipeId)).thenAnswer(
      (_) async => [
        IngredientGroup(
          id: 1,
          recipeId: recipeId,
          title: 'Test',
          orderIndex: 0,
        ),
      ],
    );

    when(() => mockDataSource.getIngredientsInRecipe(recipeId)).thenAnswer(
      (_) async => [
        IngredientInRecipe(
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
      IngredientGroup(id: 1, recipeId: 1, title: 'Group', orderIndex: 0),
    ];

    final items = [
      IngredientInRecipe(
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
      Category(id: 1, name: 'Main', icon: '🍜'),
      Category(id: 2, name: 'Desserts', icon: '🍰'),
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

    // 1. Подготавливаем "легкие" модели из датасорса
    final tRecipeModels = [
      Recipe(
        id: 1,
        name: 'Ramen',
        cookingTime: '30m',
        level: 'easy',
        categoryId: 1,
        imageUrl: '',
        isFavourite: false,
      ),
      Recipe(
        id: 2,
        name: 'Sushi',
        cookingTime: '40m',
        level: 'hard',
        categoryId: 1,
        imageUrl: '',
        isFavourite: false,
      ),
    ];

    test('should fetch recipes and then fetch details for each recipe', () async {
      // arrange
      // Когда запрашиваем список по категории, возвращаем две модели
      when(
        () => mockDataSource.getRecipesByCategory(tCategory),
      ).thenAnswer((_) async => tRecipeModels);

      // Так как метод вызывает getRecipeDetails(id), нам нужно "замокать" все внутренние вызовы
      // датасорса, которые нужны для сборки деталей (категории, ингредиенты и т.д.)
      // Для простоты здесь настроим только ID и категорию
      when(() => mockDataSource.getRecipeById(any())).thenAnswer((
        invocation,
      ) async {
        final id = invocation.positionalArguments[0] as int;
        return tRecipeModels.firstWhere((r) => r.id == id);
      });

      // Заглушки для остальных вызовов внутри getRecipeDetails
      when(
        () => mockDataSource.getCategory(any()),
      ).thenAnswer((_) async => Category(id: 1, name: 'Main', icon: ''));
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

      // Проверяем, что датасорс был опрошен для каждого рецепта
      verify(() => mockDataSource.getRecipesByCategory(tCategory)).called(1);
      verify(() => mockDataSource.getRecipeById(1)).called(1);
      verify(() => mockDataSource.getRecipeById(2)).called(1);
    });
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

}
