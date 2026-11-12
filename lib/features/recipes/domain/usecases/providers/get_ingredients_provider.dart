import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otakukitchen/features/recipes/domain/repositories/recipe_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../get_ingredients.dart';

part 'get_ingredients_provider.g.dart';

@riverpod
GetIngredientsUseCase getIngredientsUseCase(
    Ref ref,
    ) {
  final repository = ref.watch(recipeRepositoryProvider);
  return GetIngredientsUseCase(repository);
}
