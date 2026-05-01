import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:otakukitchen/features/recipes/domain/entities/recipe_entity.dart';
import 'package:otakukitchen/features/recipes/domain/repositories/recipe_repository_provider.dart';

part 'recipes_by_category_provider.g.dart';

@riverpod
Future<List<RecipeEntity>> recipesByCategory(
  Ref ref,
  String categoryName,
) async {
  final repository = ref.watch(recipeRepositoryProvider);
  return repository.getRecipesByCategory(categoryName);
}
