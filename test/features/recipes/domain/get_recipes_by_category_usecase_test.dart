import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:otakukitchen/features/recipes/domain/entities/recipe_entity.dart';
import 'package:otakukitchen/features/recipes/domain/repositories/recipe_repository.dart';
import 'package:otakukitchen/features/recipes/domain/usecases/get_recipes_by_category.dart';


class MockRecipeRepository extends Mock implements RecipeRepository {}

void main() {
  late GetRecipesListUseCase useCase;
  late MockRecipeRepository mockRepository;

  setUp(() {
    mockRepository = MockRecipeRepository();
    useCase = GetRecipesListUseCase(mockRepository);
  });

  const tCategory = 'Супы';

  final tRecipesList = <RecipeEntity>[];

  test('should get recipes for the category from the repository', () async {
    when(
      () => mockRepository.getRecipesByCategory(any()),
    ).thenAnswer((_) async => tRecipesList);

    // act 
    final result = await useCase(tCategory);

    // assert 
    expect(result, tRecipesList);

    verify(() => mockRepository.getRecipesByCategory(tCategory)).called(1);

    verifyNoMoreInteractions(mockRepository);
  });

test('should throw an exception when the repository fails', () async {
    // arrange
    when(
      () => mockRepository.getRecipesByCategory(any()),
    ).thenAnswer((_) async => throw Exception('Repository error'));

    // act
    final call = useCase(tCategory);

    // assert
    expect(call, throwsA(isA<Exception>()));
  });
}
