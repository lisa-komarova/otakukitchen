import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otakukitchen/features/recipes/domain/repositories/recipe_repository_provider.dart';
import 'package:otakukitchen/features/recipes/domain/usecases/get_recipes_amount.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_recipes_amount_provider.g.dart';


@riverpod
GetRecipesAmountUseCase getRecipesAmountUseCase(
  Ref ref,
) {
  final repository = ref.watch(recipeRepositoryProvider);
  return GetRecipesAmountUseCase(repository);
}
