import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:otakukitchen/features/recipes/domain/entities/category_entity.dart';
import 'package:otakukitchen/features/recipes/domain/repositories/recipe_repository.dart';
import 'package:otakukitchen/features/recipes/domain/usecases/get_categories.dart'; // проверь путь

class MockRecipeRepository extends Mock implements RecipeRepository {}

void main() {
  late GetCategoriesUseCase useCase;
  late MockRecipeRepository mockRepository;

  setUp(() {
    mockRepository = MockRecipeRepository();
    useCase = GetCategoriesUseCase(mockRepository);
  });

  final testCategories = [
    CategoryEntity(id: 1, name: 'Main', icon: '🍜'),
    CategoryEntity(id: 2, name: 'Desserts', icon: '🍰'),
  ];

  test(
    'should return list of categories when repository call is successful',
    () async {
      // arrange
      when(
        () => mockRepository.getCategories(),
      ).thenAnswer((_) async => testCategories);

      // act
      final result = await useCase();

      // assert
      expect(result, testCategories);
      verify(() => mockRepository.getCategories()).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test('should throw exception when repository fails', () async {
    // arrange
    when(() => mockRepository.getCategories()).thenThrow(Exception());

    // act & assert
    expect(() => useCase(), throwsA(isA<Exception>()));
    verify(() => mockRepository.getCategories()).called(1);
  });
}
