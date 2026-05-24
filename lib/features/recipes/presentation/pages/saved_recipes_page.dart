import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otakukitchen/core/theme.dart';
import 'package:otakukitchen/features/recipes/presentation/providers/favourite_recipes_provider.dart';
import 'package:otakukitchen/features/recipes/presentation/widgets/recipe_card.dart';

import '../../domain/entities/saved_mode.dart';
import '../providers/cooked_recipes_provider.dart';
import '../providers/recipes_amount_provider.dart';

class SavedRecipesPage extends ConsumerStatefulWidget {
  const SavedRecipesPage({super.key});
  @override
  ConsumerState<SavedRecipesPage> createState() => _SavedRecipesPageState();
}

class _SavedRecipesPageState extends ConsumerState<SavedRecipesPage> {
  SavedMode _currentMode = SavedMode.favourite;
  @override
  Widget build(BuildContext context) {
    final recipesAsync = _currentMode == SavedMode.favourite
        ? ref.watch(favouriteRecipesProvider)
        : ref.watch(cookedRecipesProvider);
    final recipesAmountAsync = ref.watch(recipesAmountProvider);
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        backgroundColor: isDarkMode
            ? AppColors.primaryColor
            : AppColors.background,
        body: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildSavedTabs(),
                const SizedBox(height: 15),
                Expanded(
                  child: recipesAsync.when(
                    data: (recipes) => RefreshIndicator(
                      color: AppColors.primaryColor,
                      backgroundColor: isDarkMode
                          ? AppColors.cardColor
                          : Colors.white,
                      onRefresh: () async {
                        return _currentMode == SavedMode.favourite
                            ? ref.refresh(favouriteRecipesProvider.future)
                            : ref.refresh(cookedRecipesProvider.future);
                      },
                      child: recipes.isEmpty
                          ? Center(
                              child: Text(
                                'Рецептов пока нет :(',
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineMedium,
                              ),
                            )
                          : Column(
                            children: [
                              if(_currentMode == SavedMode.cooked)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16,),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: recipesAmountAsync.when(
                                    data: (totalAmount) => Text(
                                      'Приготовлено рецептов ${recipes.length}/$totalAmount',
                                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 20),
                                    ),
                                    loading: () => const CircularProgressIndicator(),
                                    error: (error, stack) => Text('?'),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    itemCount: recipes.length,
                                    itemBuilder: (context, index) {
                                      return RecipeCard(recipe: recipes[index]);
                                    },
                                  ),
                              ),
                            ],
                          ),
                    ),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (err, stack) => Center(child: Text('Ошибка: $err')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSavedTabs() {
    return Row(
      children: [
        _tabButton("Избранные\nрецепты", SavedMode.favourite),
        const SizedBox(width: 15),
        _tabButton("Приготовленные\nрецепты", SavedMode.cooked),
      ],
    );
  }

  Widget _tabButton(String text, SavedMode mode) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final bool isActive = _currentMode == mode;
    final Color activeColor = isDarkMode
        ? AppColors.secondary
        : AppColors.primaryColor;
    final Color inactiveColor = Colors.white;
    final Color activeTextColor = Colors.white;
    final Color inactiveTextColor = AppColors.primaryColor;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _currentMode = mode),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? activeColor : inactiveColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isActive ? activeTextColor : inactiveTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
