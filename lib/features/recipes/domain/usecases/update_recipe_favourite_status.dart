import 'package:otakukitchen/features/recipes/domain/repositories/recipe_repository.dart';

class UpdateRecipeFavouriteStatusUseCase {
  RecipeRepository repository;
  UpdateRecipeFavouriteStatusUseCase(this.repository);

  Future<void> call(bool isFavourite, int recipeId) {
    return repository.updateRecipeFavouriteStatus(isFavourite, recipeId);
  }
}
