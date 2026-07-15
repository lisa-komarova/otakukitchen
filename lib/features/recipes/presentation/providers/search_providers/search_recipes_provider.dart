import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otakukitchen/features/recipes/domain/entities/search_mode.dart';
import 'package:otakukitchen/features/recipes/domain/usecases/providers/search_recipes_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/entities/recipe_card_info.dart';


part 'search_recipes_provider.g.dart';

@riverpod
Future<List<RecipeCardInfoEntity>> searchRecipes(
  Ref ref, {
  required String query,
  required SearchMode mode,  
  String? levels,  
  String? categories, 
}) {
  final useCase = ref.watch(searchRecipesUseCaseProvider);

  return useCase.call(
    query: query,
    mode: mode,
    levels: levels,
    categories: categories,
  );
}
