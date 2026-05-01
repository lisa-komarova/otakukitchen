import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:otakukitchen/features/recipes/domain/entities/recipe_entity.dart';
import 'package:otakukitchen/features/recipes/domain/repositories/recipe_repository_provider.dart';
import 'package:otakukitchen/features/recipes/presentation/providers/recipes_by_category_provider.dart';

part 'recipe_details_provider.g.dart';

@riverpod
class RecipeDetailsController extends _$RecipeDetailsController {
  @override
  FutureOr<RecipeEntity> build(int id) async {
    final repository = ref.watch(recipeRepositoryProvider);
    return repository.getRecipeDetails(id);
  }

  Future<void> toggleFavorite() async {
    final oldRecipe = state.valueOrNull;
    if (oldRecipe == null) return;

    final newStatus = !oldRecipe.isFavourite;

    state = AsyncData(oldRecipe.copyWith(isFavourite: newStatus));

    try {
      final repository = ref.read(recipeRepositoryProvider);
      await repository.updateRecipeFavouriteStatus(newStatus, id);

      ref.invalidate(recipesByCategoryProvider);
    } catch (e, _) {
      state = AsyncData(oldRecipe);
    }
  }
}
