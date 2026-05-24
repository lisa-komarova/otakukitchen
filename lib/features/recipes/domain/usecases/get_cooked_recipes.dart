import 'package:otakukitchen/features/recipes/domain/entities/recipe_entity.dart';
import 'package:otakukitchen/features/recipes/domain/repositories/recipe_repository.dart';

class GetCookedRecipesListUseCase {
  final RecipeRepository repository;

  GetCookedRecipesListUseCase(this.repository);

  Future<List<RecipeEntity>> call() {
    return repository.getCookedRecipes();
  }
}