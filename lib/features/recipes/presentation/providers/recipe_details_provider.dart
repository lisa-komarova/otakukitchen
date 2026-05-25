import 'package:otakukitchen/features/recipes/domain/usecases/providers/get_recipe_details_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:otakukitchen/features/recipes/domain/entities/recipe_entity.dart';
import 'package:otakukitchen/features/recipes/domain/repositories/recipe_repository_provider.dart';
import 'package:otakukitchen/features/recipes/presentation/providers/recipes_by_category_provider.dart';

import '../../domain/usecases/providers/update_recipe_cooked_status_provider.dart';

part 'recipe_details_provider.g.dart';

@riverpod
class RecipeDetailsController extends _$RecipeDetailsController {
  @override
  FutureOr<RecipeEntity> build(int id) async {
    final useCase = ref.watch(getRecipeDetailsUseCaseProvider);
    return useCase.call(id);
  }

  Future<void> toggleFavorite() async {
    final oldRecipe = state.valueOrNull;
    if (oldRecipe == null) return;

    final newStatus = !oldRecipe.isFavourite;

    state = AsyncData(oldRecipe.copyWith(isFavourite: newStatus));

    try {
      final useCase = ref.watch(updateRecipeCookedStatusUseCaseProvider);
      useCase.call(newStatus, id);
      ref.invalidate(recipesByCategoryProvider);
    } catch (e, _) {
      state = AsyncData(oldRecipe);
    }
  }

  Future<void> toggleCooked(bool isCooked) async {
    final oldRecipe = state.valueOrNull;
    if (oldRecipe == null) return;

    final newStatus = isCooked;

    state = AsyncData(oldRecipe.copyWith(isCooked: newStatus));

    try {
      final useCase = ref.read(updateRecipeCookedStatusUseCaseProvider);
      await useCase.call(newStatus, id);

      ref.invalidate(recipesByCategoryProvider);
    } catch (e, _) {
      state = AsyncData(oldRecipe);
    }
  }
}
