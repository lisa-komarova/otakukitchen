import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otakukitchen/core/theme.dart';
import 'package:otakukitchen/features/recipes/domain/entities/category_entity.dart';
import 'package:otakukitchen/features/recipes/presentation/providers/recipes_by_category_provider.dart';
import 'package:otakukitchen/features/recipes/presentation/widgets/recipe_card.dart';

class RecipesPage extends ConsumerWidget {
  final CategoryEntity category;

  const RecipesPage({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipesAsync = ref.watch(recipesByCategoryProvider(category.name));
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode
          ? AppColors.primaryColor
          : AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          category.name,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: isDarkMode ? AppColors.surface : AppColors.primaryColor,
          ),
        ),
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/arrow_back.png',
            width: 35,
            height: 35,
            color: isDarkMode ? AppColors.surface : AppColors.primaryColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        iconTheme: IconThemeData(
          color: isDarkMode ? AppColors.surface : AppColors.primaryColor,
        ),
      ),
      body: recipesAsync.when(
        data: (recipes) => recipes.isEmpty
            ? const Center(child: Text('Рецептов пока нет :( )'))
            : ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  return RecipeCard(recipe: recipes[index]);
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Ошибка: $err')),
      ),
    );
  }
}
