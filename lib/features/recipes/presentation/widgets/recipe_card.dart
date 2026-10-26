import 'package:flutter/material.dart';
import 'package:otakukitchen/core/theme.dart';
import 'package:otakukitchen/features/recipes/presentation/pages/recipe_details_page.dart';

import '../../domain/entities/recipe_card_info.dart';

class RecipeCard extends StatelessWidget {
  final RecipeCardInfoEntity recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
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
              _RecipeImage(imageUrl: 'assets/images/${recipe.imageUrl}'),
              const SizedBox(width: 15),
              Expanded(child: _RecipeInfo(recipe: recipe)),
              Image.asset(
                'assets/icons/forward.png',
                width: 16,
                height: 16,
                color: AppColors.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecipeImage extends StatelessWidget {
  final String imageUrl;
  const _RecipeImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.asset(
        imageUrl,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          color: AppColors.primaryColor,
          child: Image.asset('assets/splash_logo.png'),
        ),
      )
    );
  }
}

class _RecipeInfo extends StatelessWidget {
  final RecipeCardInfoEntity recipe;
  const _RecipeInfo({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          recipe.name,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          recipe.animeTitle,
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
        if (recipe.cookingTime.isNotEmpty)
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '~${recipe.cookingTime} мин',
              style: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(color: AppColors.primaryColor),
            ),
          ],
        ),
      ],
    );
  }
}
