import 'package:otakukitchen/features/recipes/domain/repositories/recipe_repository.dart';

class UpdateRecipeCookedStatusUseCase {
  RecipeRepository repository;
  UpdateRecipeCookedStatusUseCase(this.repository);

  Future<void> call(bool isCooked, int recipeId) {
    return repository.updateRecipeCookedStatus(isCooked, recipeId);
  }
}
