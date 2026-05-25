import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otakukitchen/features/recipes/domain/repositories/recipe_repository_provider.dart';
import 'package:otakukitchen/features/recipes/domain/usecases/get_recipe_details.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_recipe_details_provider.g.dart';

@riverpod
GetRecipeDetailsUseCase getRecipeDetailsUseCase(
    Ref ref,
    ) {
  final repository = ref.watch(recipeRepositoryProvider);
  return GetRecipeDetailsUseCase(repository);
}
