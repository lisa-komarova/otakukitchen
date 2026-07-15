import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:otakukitchen/features/recipes/domain/entities/anime_entity.dart';
import 'package:otakukitchen/features/recipes/domain/entities/category_entity.dart';
import 'package:otakukitchen/features/recipes/domain/entities/recipe_card_info.dart';
import 'package:otakukitchen/features/recipes/domain/entities/recipe_entity.dart';
import 'package:otakukitchen/features/recipes/domain/entities/search_mode.dart';
import 'package:otakukitchen/features/recipes/domain/repositories/recipe_repository.dart';
import 'package:otakukitchen/features/recipes/domain/usecases/search_recipes.dart';

class MockRecipeRepository extends Mock implements RecipeRepository {}

void main() {
  late SearchRecipesUseCase useCase;
  late MockRecipeRepository mockRepository;

  setUp(() {
    mockRepository = MockRecipeRepository();
    useCase = SearchRecipesUseCase(mockRepository);
  });

  const tQuery = 'Рамен';

  const tLevelsQuery = "'easy', 'medium'";
  const tCategoriesQuery = "'soup', 'main'";

  final tRecipes = [
    RecipeCardInfoEntity(
      id: 1,
      name: 'Тестовый сэндвич',
      cookingTime: '10',
      imageUrl: 'https://test.com',
      animeTitle: 'Название аниме',
    ),
  ];

  group('SearchRecipesUseCase', () {
    test(
      'should call searchRecipesByName on repository when mode is byName',
      () async {
        // Arrange
        when(
          () => mockRepository.searchRecipesByName(any(), any(), any()),
        ).thenAnswer((_) async => tRecipes);

        // Act
        final result = await useCase.call(
          query: tQuery,
          mode: SearchMode.byName,
          levels: tLevelsQuery,
          categories: tCategoriesQuery,
        );

        // Assert
        expect(result, tRecipes);
        verify(
          () => mockRepository.searchRecipesByName(
            tQuery,
            tLevelsQuery,
            tCategoriesQuery,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test(
      'should call searchRecipesByAnimeTitle on repository when mode is byAnime',
      () async {
        // Arrange
        when(
          () => mockRepository.searchRecipesByAnimeTitle(any(), any(), any()),
        ).thenAnswer((_) async => tRecipes);

        // Act
        final result = await useCase.call(
          query: tQuery,
          mode: SearchMode.byAnime,
          levels: tLevelsQuery,
          categories: tCategoriesQuery,
        );

        // Assert
        expect(result, tRecipes);
        verify(
          () => mockRepository.searchRecipesByAnimeTitle(
            tQuery,
            tLevelsQuery,
            tCategoriesQuery,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test(
      'should pass empty strings when levels and categories are null',
      () async {
        // Arrange
        when(
          () => mockRepository.searchRecipesByName(any(), any(), any()),
        ).thenAnswer((_) async => tRecipes);

        // Act
        await useCase.call(
          query: tQuery,
          mode: SearchMode.byName,
          levels: null,
          categories: null,
        );

        // Assert
        verify(
          () => mockRepository.searchRecipesByName(tQuery, '', ''),
        ).called(1);
      },
    );
  });
}
