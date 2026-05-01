import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otakukitchen/core/theme.dart';
import 'package:otakukitchen/features/recipes/domain/entities/recipe_entity.dart';
import 'package:otakukitchen/features/recipes/presentation/providers/checked_items_provider.dart';
import 'package:otakukitchen/features/recipes/presentation/providers/recipe_details_provider.dart';
import 'package:otakukitchen/features/recipes/presentation/widgets/chekable_item.dart';
import 'package:url_launcher/url_launcher.dart';

class RecipeDetailsPage extends ConsumerStatefulWidget {
  final int recipeId;
  const RecipeDetailsPage({super.key, required this.recipeId});
  @override
  ConsumerState<RecipeDetailsPage> createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends ConsumerState<RecipeDetailsPage> {
  bool isIngredientExpanded = true;
  bool isPreparationExpanded = true;

  @override
  Widget build(BuildContext context) {
    final recipeAsync = ref.watch(
      recipeDetailsControllerProvider(widget.recipeId),
    );
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    const defaultTiktokLink = 'https://www.tiktok.com/@otakukitchen';
    const defaultTelegramLink = 'https://t.me/otakukitchen';
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
                    SliverAppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      leading: IconButton(
                        icon: Image.asset(
                          'assets/icons/arrow_back.png',
                          width: 35,
                          height: 35,
                          color: isDarkMode
                              ? AppColors.surface
                              : AppColors.primaryColor,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      iconTheme: IconThemeData(
                        color: isDarkMode
                            ? AppColors.surface
                            : AppColors.primaryColor,
                      ),
                      actions: [
                        IconButton(
                          icon: Icon(Icons.tiktok, size: 30),
                          onPressed: () => _openTikTok(
                            recipe.tiktokUrl ?? defaultTiktokLink,
                          ),
                        ),
                        IconButton(
                          onPressed: () => _openTelegram(
                            recipe.telegramUrl ?? defaultTelegramLink,
                          ),
                          icon: Icon(Icons.telegram, size: 30),
                        ),
                        recipeAsync.when(
                          data: (recipe) => IconButton(
                            icon: Image.asset(
                              recipe.isFavourite
                                  ? 'assets/icons/favourite_filled.png'
                                  : 'assets/icons/favourite.png',
                              width: 35,
                              height: 35,
                              color: isDarkMode
                                  ? AppColors.surface
                                  : AppColors.primaryColor,
                            ),
                            onPressed: () {
                              ref
                                  .read(
                                    recipeDetailsControllerProvider(
                                      widget.recipeId,
                                    ).notifier,
                                  )
                                  .toggleFavorite();
                            },
                          ),
                          loading: () => CircularProgressIndicator(),
                          error: (err, stack) => Text('Error'),
                        ),
                      ],
                    ),
                    _buildHeader(recipe, context),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          _buildIngredients(recipe, context),
                          _buildPreparation(recipe, context),
                        ],
                      ),
                    ),
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
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
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
                      AutoSizeText(
                        recipe.name,
                        style: Theme.of(
                          context,
                        ).textTheme.headlineLarge!.copyWith(height: 0.8),
                        softWrap: true,
                        minFontSize: 15,
                        maxLines: 2,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          recipe.animes.first.title,
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.italic,
                                fontSize: 18,
                                height: 0.8,
                              ),

                          softWrap: true,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 3),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${recipe.cookingTime} мин',
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
                child: CachedNetworkImage(
                  imageUrl: recipe.imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.white10,
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
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
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            width: double.infinity,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: isDarkMode ? AppColors.secondary : AppColors.surface,
              borderRadius: const BorderRadius.all(Radius.circular(40)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(
                        () => isIngredientExpanded = !isIngredientExpanded,
                      );
                    },
                    behavior: HitTestBehavior.opaque,
                    child: SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'ингредиенты',
                          style: Theme.of(context).textTheme.headlineLarge!
                              .copyWith(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                  ),

                  AnimatedCrossFade(
                    duration: const Duration(milliseconds: 300),
                    sizeCurve: Curves.easeInOut,
                    crossFadeState: isIngredientExpanded
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    firstChild: const SizedBox(width: double.infinity),
                    secondChild: Column(
                      children: [
                        ...recipe.ingredientGroups.map((group) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (group.title.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 16,
                                    bottom: 8,
                                  ),
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
                                  color: isDarkMode
                                      ? AppColors.secondary
                                      : AppColors.surface,
                                ),
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: -5,
            right: -5,
            child: Image.asset(
              'assets/icons/star_filled.png',
              color: isDarkMode ? AppColors.surface : AppColors.primaryColor,
              width: 35,
              height: 35,
            ),
          ),
          Positioned(
            bottom: -5,
            left: -5,
            child: Image.asset(
              'assets/icons/star_filled.png',
              color: isDarkMode ? AppColors.surface : AppColors.primaryColor,
              width: 35,
              height: 35,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreparation(RecipeEntity recipe, BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            width: double.infinity,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: isDarkMode ? AppColors.secondary : AppColors.surface,
              borderRadius: const BorderRadius.all(Radius.circular(40)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => setState(
                      () => isPreparationExpanded = !isPreparationExpanded,
                    ),
                    behavior: HitTestBehavior.opaque,
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 19,
                          vertical: 10,
                        ),
                        child: Center(
                          child: Text(
                            'приготовление',
                            style: Theme.of(context).textTheme.headlineLarge!
                                .copyWith(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  AnimatedCrossFade(
                    duration: const Duration(milliseconds: 300),
                    sizeCurve: Curves.easeInOut,
                    crossFadeState: isPreparationExpanded
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    firstChild: const SizedBox(width: double.infinity),
                    secondChild: Column(
                      children: [
                        const SizedBox(height: 20),
                        ...recipe.sections.map((section) {
                          final sectionIndex =
                              recipe.sections.indexOf(section) + 1;
                          return Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(
                              bottom: 20,
                              left: 20,
                              right: 20,
                            ),
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? AppColors.cardColor
                                  : Colors.white,
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
                                    textColor: isDarkMode
                                        ? AppColors.textPrimary
                                        : null,
                                    color: isDarkMode
                                        ? AppColors.cardColor
                                        : Colors.white,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: SizedBox(
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
                              child: Text(
                                'приготовлено',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      color: isDarkMode
                                          ? AppColors.cardColor
                                          : Colors.white,
                                    ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: -5,
            right: -5,
            child: Image.asset(
              'assets/icons/star_filled.png',
              color: isDarkMode ? AppColors.surface : AppColors.primaryColor,
              width: 35,
              height: 35,
            ),
          ),
          Positioned(
            bottom: -5,
            left: -5,
            child: Image.asset(
              'assets/icons/star_filled.png',
              color: isDarkMode ? AppColors.surface : AppColors.primaryColor,
              width: 35,
              height: 35,
            ),
          ),
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
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: isDarkMode ? AppColors.secondary : null,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              backgroundColor: AppColors.secondary,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'ОТМЕНА',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Color(0xFF301659),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          TextButton(
            onPressed: () {
              ref.read(checkedItemsProvider.notifier).clearAll();
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
            child: Text(
              'ПОДТВЕРДИТЬ',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: AppColors.accent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openTikTok(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _openTelegram(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
