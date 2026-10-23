import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otakukitchen/features/recipes/domain/usecases/providers/get_recipes_by_category_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/recipe_card_info.dart';

part 'recipes_by_category_provider.g.dart';

@riverpod
Future<List<RecipeCardInfoEntity>> recipesByCategory(
  Ref ref,
  String categoryName,
) async {
  final useCase = ref.watch(getRecipesByCategoryUseCaseProvider);
  return useCase.call(categoryName);
}
