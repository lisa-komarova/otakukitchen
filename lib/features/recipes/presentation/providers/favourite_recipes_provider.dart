import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otakukitchen/features/recipes/domain/usecases/providers/get_favourite_recipes_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/recipe_card_info.dart';

part 'favourite_recipes_provider.g.dart';

@riverpod
Future<List<RecipeCardInfoEntity>> favouriteRecipes(Ref ref) async {
  final useCase = ref.watch(getFavouriteRecipesListUseCaseProvider);
  return useCase.call();
}
