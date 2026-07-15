import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/recipe_card_info.dart';
import '../../domain/usecases/providers/get_cooked_recipes_provider.dart';

part 'cooked_recipes_provider.g.dart';

@riverpod
Future<List<RecipeCardInfoEntity>> cookedRecipes(Ref ref) async {
  final useCase = ref.watch(getCookedRecipesUseCaseProvider);
  return useCase.call();
}
