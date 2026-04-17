import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otakukitchen/core/theme.dart';
import 'package:otakukitchen/features/recipes/domain/entities/recipe_entity.dart';
import 'package:otakukitchen/features/recipes/presentation/providers/checked_items_provider.dart';
import 'package:otakukitchen/features/recipes/presentation/providers/recipe_details_provider.dart';
import 'package:otakukitchen/features/recipes/presentation/widgets/chekable_item.dart';

class RecipeDetailsPage extends ConsumerWidget {
  final int recipeId;
  const RecipeDetailsPage({super.key, required this.recipeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipeAsync = ref.watch(recipeDetailsProvider(recipeId));
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return SafeArea(
      top: false,
      child: Scaffold(
        extendBody: true,
        backgroundColor: isDarkMode
            ? AppColors.primaryColor
            : AppColors.background,
        body: recipeAsync.when(
          loading: () => const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
          error: (err, _) => Center(child: Text('Error: $err')),
          data: (recipe) => Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    _buildHeader(recipe, context),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? AppColors.secondary
                                : AppColors.surface,
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                          child: Column(
                            children: [
                              _buildIngredients(recipe, context),
                              _buildPreparation(recipe, context),
                              _buildSocialAndAction(context, ref),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(child: SizedBox(height: 75)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(RecipeEntity recipe, BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    const Map<String, String> levelTranslation = {
      'easy': 'легкая сложность',
      'medium': 'средняя сложность',
      'hard': 'высокая сложность',
    };
    int iconCount = 1;
    if (recipe.level == 'medium') iconCount = 2;
    if (recipe.level == 'hard') iconCount = 3;
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 20),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipe.name,
                        style: Theme.of(
                          context,
                        ).textTheme.headlineLarge!.copyWith(height: 0.8),
                        softWrap: true,
                        maxLines: 2,
                      ),
                      Text(
                        recipe.animes.first.title,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.italic,
                          fontSize: 18,
                        ),

                        softWrap: true,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      recipe.cookingTime,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge!.copyWith(fontSize: 18),
                    ),
                    Tooltip(
                      message: levelTranslation[recipe.level] ?? recipe.level,
                      child: Row(
                        children: [
                          ...List.generate(
                            iconCount,
                            (index) => Image.asset(
                              'assets/icons/level.png',
                              width: 20,
                              height: 20,
                              color: isDarkMode ? Colors.white : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                border: BoxBorder.all(color: Colors.white, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(100),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Image.network(
                  recipe.imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.white24,
                    child: const Icon(
                      Icons.restaurant,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIngredients(RecipeEntity recipe, BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            'ингредиенты',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          ...recipe.ingredientGroups.map(
            (group) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (group.title.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      group.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),

                ...group.ingredients.map(
                  (ing) => CheckableItem(
                    id: 'group_${group.title}_ing_${ing.id}_${ing.name}',
                    text: '${ing.name} — ${ing.amount}',
                    color: isDarkMode ? AppColors.secondary : AppColors.surface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreparation(RecipeEntity recipe, BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Column(
      children: [
        Text(
          'приготовление',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),

        ...recipe.sections.map((section) {
          final sectionIndex = recipe.sections.indexOf(section) + 1;

          return Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDarkMode ? AppColors.cardColor : Colors.white,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$sectionIndex. ${section.title}:',
                  style: const TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 12),
                ...section.steps.map(
                  (step) => CheckableItem(
                    id: 'step_${section.title}_${step.stepNumber}',
                    text: step.description,
                    textColor: isDarkMode ? AppColors.textPrimary : null,
                    color: isDarkMode ? AppColors.cardColor : Colors.white,
                  ),
                ),
                if (recipe.sections.last == section)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text(
                        'Приятного аппетита!',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildSocialAndAction(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.tiktok,
                color: AppColors.primaryColor,
                size: 30,
              ), // Replace with SVG if needed
              Icon(Icons.telegram, color: AppColors.primaryColor, size: 30),
              Icon(
                Icons.favorite_border,
                color: AppColors.primaryColor,
                size: 30,
              ),
            ],
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () => _showResetDialog(context, ref),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'приготовлено',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  
  void _showResetDialog(BuildContext context, WidgetRef ref) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Готово?',
          style: TextStyle(
            color: isDarkMode ? Colors.white : AppColors.primaryColor,
          ),
        ),
        content: Text(
          'При нажатии "приготовлено" все ингредиенты и шаги будут сброшены',
          style: TextStyle(color: isDarkMode ? AppColors.secondary : null),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              backgroundColor: AppColors.secondary, // Светло-фиолетовый фон
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Скругление углов
              ),
            ),
            child: const Text(
              'ОТМЕНА',
              style: TextStyle(
                color: Color(0xFF301659),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          TextButton(
            onPressed: () {
              ref.read(checkedItemsProvider.notifier).state = {};
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Прогресс сброшен')));
            },
            style: TextButton.styleFrom(
              backgroundColor: isDarkMode
                  ? AppColors.background.withAlpha(50)
                  : AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'ПОДТВЕРДИТЬ',
              style: TextStyle(
                color: AppColors.accent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
