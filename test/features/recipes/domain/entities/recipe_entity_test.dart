import 'package:flutter_test/flutter_test.dart';
import 'package:otakukitchen/features/recipes/domain/entities/recipe_entity.dart';
import 'package:otakukitchen/features/recipes/domain/entities/category_entity.dart';

void main() {
  group('RecipeEntity', () {
   
    final tCategory = CategoryEntity(id: 1, name: 'Main', icon: '');
    final tRecipe = RecipeEntity(
      id: 1,
      name: 'Ramen',
      cookingTime: '30 min',
      level: 'easy',
      imageUrl: '',
      isFavourite: false,
      isCooked: false,
      category: tCategory,
      animes: [],
      ingredientGroups: [],
      sections: [],
    );

    test('copyWith should return a new instance with updated fields', () {
      // act
      final updated = tRecipe.copyWith(name: 'New Ramen', isFavourite: true);

      // assert 
      expect(updated.name, 'New Ramen');
      expect(updated.isFavourite, true);

      expect(updated.id, tRecipe.id);
      expect(updated.cookingTime, tRecipe.cookingTime);
    });
  });
}
