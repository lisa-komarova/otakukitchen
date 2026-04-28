import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:otakukitchen/features/recipes/domain/entities/recipe_entity.dart';
import 'package:otakukitchen/features/recipes/domain/repositories/recipe_repository.dart';
import 'package:otakukitchen/features/recipes/domain/repositories/recipe_repository_provider.dart';
import 'package:otakukitchen/features/recipes/presentation/providers/recipes_by_category_provider.dart';

class RecipeDetailsController extends StateNotifier<AsyncValue<RecipeEntity>> {
  final RecipeRepository _repository;
  final int _recipeId;
  final Ref _ref;

  RecipeDetailsController({
    required RecipeRepository repository,
    required int recipeId,
    required Ref ref,
  }) : _repository = repository,
       _recipeId = recipeId,
       _ref = ref,
       super(const AsyncLoading()) {
    loadRecipe();
  }

  Future<void> loadRecipe() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _repository.getRecipeDetails(_recipeId),
    );
  }

  Future<void> toggleFavorite() async {
    final oldRecipe = state.asData?.value;
    if (oldRecipe == null) return;

    final newStatus = !oldRecipe.isFavourite;

    state = AsyncData(oldRecipe.copyWith(isFavourite: newStatus));

    try {
      await _repository.updateRecipeFavouriteStatus(newStatus, _recipeId);
      _ref.invalidate(recipesByCategoryProvider);
    } catch (e, _) {
      state = AsyncData(oldRecipe);
    }
  }
}

final recipeDetailsProvider =
    StateNotifierProvider.family<
      RecipeDetailsController,
      AsyncValue<RecipeEntity>,
      int
    >((ref, id) {
      return RecipeDetailsController(
        repository: ref.watch(recipeRepositoryProvider),
        recipeId: id,
        ref: ref,
      );
    });
