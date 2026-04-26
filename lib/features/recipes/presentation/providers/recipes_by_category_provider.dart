import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otakukitchen/features/recipes/domain/entities/recipe_entity.dart';
import 'package:otakukitchen/features/recipes/domain/repositories/recipe_repository_provider.dart';


final recipesByCategoryProvider =
    FutureProvider.family<List<RecipeEntity>, String>((
      ref,
      categoryName,
    ) async {
      final repository = ref.watch(recipeRepositoryProvider);
      return repository.getRecipesByCategory(categoryName);
    });
