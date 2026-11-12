import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otakukitchen/features/recipes/domain/usecases/providers/get_ingredients_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/ingredient_group_entity.dart';

part 'ingredients_provider.g.dart';

@riverpod
Future<List<IngredientEntity>> ingredients(Ref ref) {
  final useCase = ref.watch(getIngredientsUseCaseProvider);

  return useCase.call();
}