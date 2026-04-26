import 'package:otakukitchen/features/recipes/domain/entities/recipe_entity.dart';
import 'package:otakukitchen/features/recipes/domain/repositories/recipe_repository.dart';

class GetRecipesListUseCase {
  final RecipeRepository repository;

  GetRecipesListUseCase(this.repository);

  Future<List<RecipeEntity>> call(String category) {
    return repository.getRecipesByCategory(category);
  }
}
