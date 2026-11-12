import 'package:otakukitchen/features/recipes/domain/entities/category_entity.dart';
import 'package:otakukitchen/features/recipes/domain/repositories/recipe_repository.dart';

import '../entities/ingredient_group_entity.dart';

class GetIngredientsUseCase {
  final RecipeRepository repository;

  GetIngredientsUseCase(this.repository);

  Future<List<IngredientEntity>> call() {
    return repository.getIngredients();
  }
}
