import 'package:otakukitchen/features/recipes/domain/entities/recipe_entity.dart';
import 'package:otakukitchen/features/recipes/domain/repositories/recipe_repository.dart';

class GetRecipeDetailsUseCase {
  final RecipeRepository repository;

  GetRecipeDetailsUseCase(this.repository);

  Future<RecipeEntity> call(int id) {
    return repository.getRecipeDetails(id);
  }
}
