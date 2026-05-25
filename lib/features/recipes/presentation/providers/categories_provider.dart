import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otakukitchen/features/recipes/domain/usecases/providers/get_categories_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:otakukitchen/features/recipes/domain/entities/category_entity.dart';
import 'package:otakukitchen/features/recipes/domain/repositories/recipe_repository_provider.dart';

part 'categories_provider.g.dart';

@riverpod
Future<List<CategoryEntity>> categories(Ref ref) async {
  final useCase = ref.watch(getCategoriesUseCaseProvider);
  return useCase.call();
}
