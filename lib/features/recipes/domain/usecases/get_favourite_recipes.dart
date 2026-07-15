import 'package:otakukitchen/features/recipes/domain/repositories/recipe_repository.dart';

import '../entities/recipe_card_info.dart';

class GetFavouriteRecipesListUseCase {
  final RecipeRepository repository;

  GetFavouriteRecipesListUseCase(this.repository);

  Future<List<RecipeCardInfoEntity>> call() {
    return repository.getFavouriteRecipes();
  }
}