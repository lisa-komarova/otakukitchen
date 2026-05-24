import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:otakukitchen/features/recipes/domain/entities/recipe_entity.dart';

import '../../domain/usecases/providers/get_cooked_recipes_provider.dart';

part 'cooked_recipes_provider.g.dart';

@riverpod
Future<List<RecipeEntity>> cookedRecipes(Ref ref) async {
  final useCase = ref.watch(getCookedRecipesUseCaseProvider);
  return useCase.call();
}
