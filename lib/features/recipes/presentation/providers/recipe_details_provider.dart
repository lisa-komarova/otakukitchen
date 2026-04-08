import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otakukitchen/features/recipes/domain/entities/recipe_entity.dart';
import 'package:otakukitchen/features/recipes/domain/repositories/recipe_repository_provider.dart';


final recipeDetailsProvider = FutureProvider.family<RecipeEntity, int>((
  ref,
  id,
) async {
  final repository = ref.watch(recipeRepositoryProvider);
  return repository.getRecipeDetails(id);
});
