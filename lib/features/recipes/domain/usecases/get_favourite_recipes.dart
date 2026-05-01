import 'package:otakukitchen/features/recipes/domain/entities/recipe_entity.dart';
import 'package:otakukitchen/features/recipes/domain/repositories/recipe_repository.dart';

class GetFavouriteRecipesListUseCase {
  final RecipeRepository repository;

  GetFavouriteRecipesListUseCase(this.repository);

  Future<List<RecipeEntity>> call() {
    return repository.getFavouriteRecipes();
  }
}