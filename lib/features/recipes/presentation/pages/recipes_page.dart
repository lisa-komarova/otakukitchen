import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otakukitchen/core/theme.dart';
import 'package:otakukitchen/features/recipes/domain/entities/category_entity.dart';
import 'package:otakukitchen/features/recipes/domain/entities/recipe_entity.dart';
import 'package:otakukitchen/features/recipes/presentation/pages/recipe_details_page.dart';
import 'package:otakukitchen/features/recipes/presentation/providers/recipes_by_category_provider.dart';

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
                  return _buildRecipeCard(recipes[index], context);
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Ошибка: $err')),
      ),
    );
  }

  Widget _buildRecipeCard(RecipeEntity recipe, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetailsPage(recipeId: recipe.id),
            ),
          );
        },
        borderRadius: BorderRadius.circular(25),
        child: Container(
          height: 150,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: recipe.imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[800],
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[800],
                    child: const Icon(Icons.error, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 15),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      recipe.name,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      recipe.animes.first.title,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                      ),
                      softWrap: true,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 18,
                          color: AppColors.primaryColor,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '${recipe.cookingTime} мин',
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
