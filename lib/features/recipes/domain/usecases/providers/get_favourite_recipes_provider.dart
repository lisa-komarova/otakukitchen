import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otakukitchen/features/recipes/domain/repositories/recipe_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../get_favourite_recipes.dart';

part 'get_favourite_recipes_provider.g.dart';

@riverpod
GetFavouriteRecipesListUseCase getFavouriteRecipesListUseCase(
    Ref ref,
    ) {
  final repository = ref.watch(recipeRepositoryProvider);
  return GetFavouriteRecipesListUseCase(repository);
}
