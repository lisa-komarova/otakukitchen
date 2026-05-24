import 'package:otakukitchen/features/recipes/domain/repositories/recipe_repository.dart';

class GetRecipesAmountUseCase {
  final RecipeRepository repository;

  GetRecipesAmountUseCase(this.repository);

  Future<int> call() {
    return repository.getRecipesAmount();
  }
}