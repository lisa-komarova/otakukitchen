import 'package:otakukitchen/features/recipes/domain/repositories/recipe_repository.dart';

import '../entities/recipe_card_info.dart';

class GetRecipesListUseCase {
  final RecipeRepository repository;

  GetRecipesListUseCase(this.repository);

  Future<List<RecipeCardInfoEntity>> call(String category) {
    return repository.getRecipesByCategory(category);
  }
}
