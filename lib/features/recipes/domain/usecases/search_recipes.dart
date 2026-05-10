import 'package:otakukitchen/features/recipes/domain/entities/recipe_entity.dart';
import 'package:otakukitchen/features/recipes/domain/entities/search_mode.dart';
import 'package:otakukitchen/features/recipes/domain/repositories/recipe_repository.dart';

class SearchRecipesUseCase {
  final RecipeRepository repository;

  SearchRecipesUseCase(this.repository);

  Future<List<RecipeEntity>> call({
    required String query,
    required SearchMode mode,
    String? levels,
    String? categories,
  }) {
    return switch (mode) {
      SearchMode.byName => repository.searchRecipesByName(
        query,
        levels ?? '',
        categories ?? '',
      ),
      SearchMode.byAnime => repository.searchRecipesByAnimeTitle(
        query,
        levels ?? '',
        categories ?? '',
      ),
    };
  }
}
