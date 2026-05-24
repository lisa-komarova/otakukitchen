import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otakukitchen/features/recipes/domain/usecases/providers/get_recipes_amount_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recipes_amount_provider.g.dart';

@riverpod
Future<int> recipesAmount(Ref ref) async {
  final useCase = ref.watch(getRecipesAmountUseCaseProvider);
  return useCase.call();
}
