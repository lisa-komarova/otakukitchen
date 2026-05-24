import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otakukitchen/features/recipes/domain/repositories/recipe_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../get_cooked_recipes.dart';

part 'get_cooked_recipes_provider.g.dart';


@riverpod
GetCookedRecipesListUseCase getCookedRecipesUseCase(
  Ref ref,
) {
  final repository = ref.watch(recipeRepositoryProvider);
  return GetCookedRecipesListUseCase(repository);
}
