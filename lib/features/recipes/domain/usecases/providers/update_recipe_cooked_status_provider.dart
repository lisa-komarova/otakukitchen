import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otakukitchen/features/recipes/domain/repositories/recipe_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../update_recipe_cooked_status.dart';

part 'update_recipe_cooked_status_provider.g.dart';


@riverpod
UpdateRecipeCookedStatusUseCase updateRecipeCookedStatusUseCase(
  Ref ref,
) {
  final repository = ref.watch(recipeRepositoryProvider);
  return UpdateRecipeCookedStatusUseCase(repository);
}
