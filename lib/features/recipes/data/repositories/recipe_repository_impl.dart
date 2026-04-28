import 'package:otakukitchen/features/recipes/data/mappers/ingredient_mapper.dart';
import 'package:otakukitchen/features/recipes/data/mappers/recipe_section_mapper.dart';
import 'package:otakukitchen/features/recipes/data/sources/recipe_local_datasource.dart';
import 'package:otakukitchen/features/recipes/domain/entities/recipe_entity.dart';
import 'package:otakukitchen/features/recipes/domain/entities/category_entity.dart';
import 'package:otakukitchen/features/recipes/domain/entities/anime_entity.dart';
import 'package:otakukitchen/features/recipes/domain/repositories/recipe_repository.dart';

class RecipeRepositoryImpl extends RecipeRepository {
  final RecipeLocalDataSource datasource;

  RecipeRepositoryImpl(this.datasource);

  @override
  Future<RecipeEntity> getRecipeDetails(int recipeId) async {
    final recipe = await datasource.getRecipeById(recipeId);
    final category = await datasource.getCategory(recipe.categoryId);
    final animes = await datasource.getAnimesByRecipe(recipeId);
    final groups = await datasource.getIngredientGroups(recipeId);
    final ingredients = await datasource.getIngredientsInRecipe(recipeId);
    final sections = await datasource.getRecipeSections(recipeId);
    final steps = await datasource.getSteps(recipeId);

    return RecipeEntity(
      id: recipe.id,
      name: recipe.name,
      cookingTime: recipe.cookingTime,
      level: recipe.level,
      imageUrl: recipe.imageUrl,
      tiktokUrl: recipe.tiktokUrl,
      telegramUrl: recipe.telegramUrl,
      isFavourite: recipe.isFavourite,
      note: recipe.note,
      category: CategoryEntity(
        id: category.id,
        name: category.name,
        icon: category.icon,
      ),
      animes: animes
          .map(
            (a) => AnimeEntity(
              id: a.id,
              title: a.title,
              sceneDescription: a.sceneDescription,
              episode: a.episode,
            ),
          )
          .toList(),
      ingredientGroups: IngredientMapper.mapGroups(groups, ingredients),
      sections: RecipeSectionMapper.mapSections(sections, steps),
    );
  }

  @override
  Future<List<CategoryEntity>> getCategories() async {
    final categories = await datasource.getCategories();
    return categories
        .map(
          (category) => CategoryEntity(
            id: category.id,
            name: category.name,
            icon: category.icon,
          ),
        )
        .toList();
  }

  @override
  Future<List<RecipeEntity>> getRecipesByCategory(String category) async {
    final recipes = await datasource.getRecipesByCategory(category);

    return Future.wait(recipes.map((recipe) => getRecipeDetails(recipe.id)));
  }

  @override
  Future<void> updateRecipeFavouriteStatus(
    bool isFavourite,
    int recipeId,
  ) async {
    await datasource.updateRecipeFavouriteStatus(isFavourite, recipeId);
  }
}
