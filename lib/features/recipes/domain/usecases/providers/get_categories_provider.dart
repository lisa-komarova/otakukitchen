import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otakukitchen/features/recipes/domain/repositories/recipe_repository_provider.dart';
import 'package:otakukitchen/features/recipes/domain/usecases/get_categories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_categories_provider.g.dart';

@riverpod
GetCategoriesUseCase getCategoriesUseCase(
    Ref ref,
    ) {
  final repository = ref.watch(recipeRepositoryProvider);
  return GetCategoriesUseCase(repository);
}
