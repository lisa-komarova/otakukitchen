import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otakukitchen/core/theme.dart';
import 'package:otakukitchen/features/recipes/presentation/providers/favourite_recipes_provider.dart';
import 'package:otakukitchen/features/recipes/presentation/widgets/recipe_card.dart';

class FavouriteRecipesPage extends ConsumerWidget {
  const FavouriteRecipesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipesAsync = ref.watch(favouriteRecipesProvider);
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
          'Избранное',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: isDarkMode ? AppColors.surface : AppColors.primaryColor,
          ),
        ),
      ),
      body: recipesAsync.when(
        data: (recipes) => RefreshIndicator(
          color: AppColors.primaryColor,
          backgroundColor: isDarkMode ? AppColors.cardColor : Colors.white,
          onRefresh: () async {
            return ref.refresh(favouriteRecipesProvider.future);
          },
          child: recipes.isEmpty
              ? Center(
                  child: Text(
                    'Рецептов пока нет :(',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(fontSize: 20, color: isDarkMode
                          ? AppColors.secondary
                          : AppColors.textPrimary,
                    ),
                  ),
                )
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
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Ошибка: $err')),
      ),
    );
  }
}
