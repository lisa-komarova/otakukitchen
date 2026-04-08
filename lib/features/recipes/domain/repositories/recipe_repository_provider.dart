import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otakukitchen/features/recipes/data/repositories/recipe_repository_impl.dart';
import 'package:otakukitchen/features/recipes/data/sources/database_provider.dart';
import 'package:otakukitchen/features/recipes/domain/repositories/recipe_repository.dart';

final recipeRepositoryProvider = Provider<RecipeRepository>((ref) {
  final dataSource = ref.watch(recipeLocalDataSourceProvider);
  return RecipeRepositoryImpl(dataSource);
});
