import 'package:otakukitchen/features/recipes/domain/repositories/recipe_repository.dart';

import '../entities/recipe_card_info.dart';

class GetCookedRecipesListUseCase {
  final RecipeRepository repository;

  GetCookedRecipesListUseCase(this.repository);

  Future<List<RecipeCardInfoEntity>> call() {
    return repository.getCookedRecipes();
  }
}