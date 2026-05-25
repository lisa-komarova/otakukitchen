import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otakukitchen/features/recipes/domain/repositories/recipe_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../update_recipe_favourite_status.dart';

part 'update_recipe_favourite_status_provider.g.dart';


@riverpod
UpdateRecipeFavouriteStatusUseCase updateRecipeFavouriteStatusUseCase(
    Ref ref,
    ) {
  final repository = ref.watch(recipeRepositoryProvider);
  return UpdateRecipeFavouriteStatusUseCase(repository);
}
