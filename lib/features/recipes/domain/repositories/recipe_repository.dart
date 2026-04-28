import 'package:otakukitchen/features/recipes/domain/entities/category_entity.dart';
import 'package:otakukitchen/features/recipes/domain/entities/recipe_entity.dart';

abstract class RecipeRepository {
  Future<RecipeEntity> getRecipeDetails(int id);
  Future<List<CategoryEntity>> getCategories();
  Future<List<RecipeEntity>> getRecipesByCategory(String category);
  Future<void> updateRecipeFavouriteStatus(bool isFavourite, int recipeId);
}
