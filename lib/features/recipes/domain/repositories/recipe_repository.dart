import 'package:otakukitchen/features/recipes/domain/entities/category_entity.dart';
import 'package:otakukitchen/features/recipes/domain/entities/recipe_entity.dart';

abstract class RecipeRepository {
  Future<RecipeEntity> getRecipeDetails(int id);
  Future<List<CategoryEntity>> getCategories();
  Future<List<RecipeEntity>> getRecipesByCategory(String category);
  Future<void> updateRecipeFavouriteStatus(bool isFavourite, int recipeId);
  Future<void> updateRecipeCookedStatus(bool isCooked, int recipeId);
  Future<List<RecipeEntity>> getFavouriteRecipes();
  Future<List<RecipeEntity>> getCookedRecipes();
  Future<int> getRecipesAmount();
  Future<List<RecipeEntity>> searchRecipesByName(
    String query,
    String levels,
    String categories,
  );
  Future<List<RecipeEntity>> searchRecipesByAnimeTitle(
    String query,
    String levels,
    String categories,
  );
}
