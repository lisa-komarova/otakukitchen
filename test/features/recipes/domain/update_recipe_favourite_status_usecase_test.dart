import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:otakukitchen/features/recipes/domain/repositories/recipe_repository.dart';
import 'package:otakukitchen/features/recipes/domain/usecases/update_recipe_favourite_status.dart';

class MockRecipeRepository extends Mock implements RecipeRepository {}

void main() {
  late UpdateRecipeFavouriteStatusUseCase useCase;
  late MockRecipeRepository mockRepository;

  setUp(() {
    mockRepository = MockRecipeRepository();
    useCase = UpdateRecipeFavouriteStatusUseCase(mockRepository);
  });

  test('should call repository to update favorite status', () async {
    // Arrange
    when(
      () => mockRepository.updateRecipeFavouriteStatus(any(), any()),
    ).thenAnswer((_) async => Future.value());

    // Act
    await useCase( true,  1);

    // Assert
    verify(
      () => mockRepository.updateRecipeFavouriteStatus(true, 1),
    ).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
