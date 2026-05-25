import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otakukitchen/features/recipes/domain/repositories/recipe_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../get_recipes_by_category.dart';

part 'get_recipes_by_category_provider.g.dart';


@riverpod
GetRecipesListUseCase getRecipesByCategoryUseCase(
    Ref ref,
    ) {
  final repository = ref.watch(recipeRepositoryProvider);
  return GetRecipesListUseCase(repository);
}
