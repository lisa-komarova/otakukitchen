import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:otakukitchen/features/recipes/domain/entities/recipe_entity.dart';
import 'package:otakukitchen/features/recipes/domain/repositories/recipe_repository_provider.dart';

part 'favourite_recipes_provider.g.dart';

@riverpod
Future<List<RecipeEntity>> favouriteRecipes(Ref ref) async {
  final repository = ref.watch(recipeRepositoryProvider);
  return repository.getFavouriteRecipes();
}
