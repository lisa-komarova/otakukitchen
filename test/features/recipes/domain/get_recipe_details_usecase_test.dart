import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:otakukitchen/features/recipes/domain/entities/category_entity.dart';

import 'package:otakukitchen/features/recipes/domain/entities/recipe_entity.dart';
import 'package:otakukitchen/features/recipes/domain/repositories/recipe_repository.dart';
import 'package:otakukitchen/features/recipes/domain/usecases/get_recipe_details.dart';

// mock
class MockRecipeRepository extends Mock implements RecipeRepository {}

void main() {
  late GetRecipeDetailsUseCase useCase;
  late MockRecipeRepository mockRepository;

  setUp(() {
    mockRepository = MockRecipeRepository();
    useCase = GetRecipeDetailsUseCase(mockRepository);
  });

  const recipeId = 1;

  final testRecipe = RecipeEntity(
    id: 1,
    name: 'Ramen',
    cookingTime: '30 min',
    level: 'easy',
    imageUrl: 'url',
    isFavourite: false,
    category: CategoryEntity(id: 1, name: 'Main', icon: '🍜'),
    animes: [],
    ingredientGroups: [],
    sections: [],
  );

  test('should return recipe when repository call is successful', () async {
    // arrange
    when(
      () => mockRepository.getRecipeDetails(recipeId),
    ).thenAnswer((_) async => testRecipe);

    // act
    final result = await useCase(recipeId);

    // assert
    expect(result, testRecipe);
    verify(() => mockRepository.getRecipeDetails(recipeId)).called(1);
  });

  test('should throw exception when repository fails', () async {
  // arrange
  when(() => mockRepository.getRecipeDetails(recipeId))
      .thenAnswer((_) async => throw Exception('Repository error'));

  // act
  final call = useCase(recipeId);

  // assert
  expect(() => call, throwsA(isA<Exception>()));
});


}
