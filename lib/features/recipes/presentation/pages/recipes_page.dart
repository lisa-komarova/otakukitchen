import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otakukitchen/core/theme.dart';
import 'package:otakukitchen/features/recipes/domain/entities/category_entity.dart';
import 'package:otakukitchen/features/recipes/presentation/providers/recipes_by_category_provider.dart';
import 'package:otakukitchen/features/recipes/presentation/widgets/recipe_card.dart';

class RecipesPage extends ConsumerStatefulWidget {
  final CategoryEntity category;

  const RecipesPage({super.key, required this.category});

  @override
  ConsumerState<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends ConsumerState<RecipesPage> {
  final ScrollController _verticalController = ScrollController();

  @override
  void dispose() {
    _verticalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recipesAsync = ref.watch(recipesByCategoryProvider(widget.category.name));
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
          widget.category.name,
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
      body: SafeArea(
        top: false,
        child: recipesAsync.when(
          data: (recipes) => recipes.isEmpty
              ? const Center(child: Text('Рецептов пока нет :( )'))
              : OrientationBuilder(
                  builder: (ctx, orientation) {
                    final isLandscape = orientation == Orientation.landscape;
                    if (isLandscape) {
                      return GridView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        itemCount: recipes.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 1.2,
                            ),
                        itemBuilder: (context, index) =>
                            RecipeCard(recipe: recipes[index]),
                      );
                    } else {
                      return Scrollbar(
                        controller: _verticalController,
                        thumbVisibility: true,
                        trackVisibility: true,
                        interactive: true,
                        child: ListView.builder(
                          controller: _verticalController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          itemCount: recipes.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: RecipeCard(recipe: recipes[index]),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Ошибка: $err')),
        ),
      ),
    );
  }
}
