import 'package:otakukitchen/features/recipes/domain/entities/category_entity.dart';
import 'package:otakukitchen/features/recipes/domain/entities/recipe_entity.dart';

import '../entities/recipe_card_info.dart';

abstract class RecipeRepository {
  Future<RecipeEntity> getRecipeDetails(int id);
  Future<List<CategoryEntity>> getCategories();
  Future<List<RecipeCardInfoEntity>> getRecipesByCategory(String category);
  Future<void> updateRecipeFavouriteStatus(bool isFavourite, int recipeId);
  Future<void> updateRecipeCookedStatus(bool isCooked, int recipeId);
  Future<List<RecipeCardInfoEntity>> getFavouriteRecipes();
  Future<List<RecipeCardInfoEntity>> getCookedRecipes();
  Future<int> getRecipesAmount();
  Future<List<RecipeCardInfoEntity>> searchRecipesByName(
    String query,
    String levels,
    String categories,
  );
  Future<List<RecipeCardInfoEntity>> searchRecipesByAnimeTitle(
    String query,
    String levels,
    String categories,
  );
}
