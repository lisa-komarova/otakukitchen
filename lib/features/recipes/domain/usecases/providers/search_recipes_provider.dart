import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otakukitchen/features/recipes/domain/repositories/recipe_repository_provider.dart';
import 'package:otakukitchen/features/recipes/domain/usecases/search_recipes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_recipes_provider.g.dart';


@riverpod
SearchRecipesUseCase searchRecipesUseCase(
  Ref ref,
) {
  final repository = ref.watch(recipeRepositoryProvider);
  return SearchRecipesUseCase(repository);
}
