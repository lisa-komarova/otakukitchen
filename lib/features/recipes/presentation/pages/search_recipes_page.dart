import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otakukitchen/core/theme.dart';
import 'package:otakukitchen/features/recipes/domain/entities/search_mode.dart';
import 'package:otakukitchen/features/recipes/presentation/providers/search_providers/search_recipes_provider.dart';
import 'package:otakukitchen/features/recipes/presentation/widgets/recipe_card.dart';

import '../../domain/entities/ingredient_group_entity.dart';
import '../../domain/entities/recipe_card_info.dart';
import '../providers/ingredients_provider.dart';

class SearchRecipesPage extends ConsumerStatefulWidget {
  const SearchRecipesPage({super.key});

  @override
  ConsumerState<SearchRecipesPage> createState() => _SearchRecipesPageState();
}

class _SearchRecipesPageState extends ConsumerState<SearchRecipesPage> {
  final TextEditingController _searchController = TextEditingController();
  SearchMode _currentMode = SearchMode.byName;
  final ({Set<String> categories, Set<String> levels, Set<int> ingredientIds})
  _filters = (categories: {}, levels: {}, ingredientIds: {});
  @override
  Widget build(BuildContext context) {
    final Map<String, String> difficultyMapping = {
      "Легко": "easy",
      "Средне": "medium",
      "Сложно": "hard",
    };
    final searchAsync = ref.watch(
      searchRecipesProvider(
        query: _searchController.text,
        mode: _currentMode,
        categories: _filters.categories.map((c) => "'$c'").join(','),
        levels: _filters.levels
            .map((d) => "'${difficultyMapping[d] ?? d}'")
            .join(','),
        ingredients: _filters.ingredientIds.join(','),
        numberOfIngredients: _filters.ingredientIds.length,
      ),
    );
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        backgroundColor: isDarkMode
            ? AppColors.primaryColor
            : AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildSearchTabs(),
                const SizedBox(height: 15),
                _buildSearchInput(),
                const SizedBox(height: 20),
                Expanded(
                  child: searchAsync.when(
                    data: (recipes) => _buildRecipeList(recipes),
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

  Widget _buildSearchTabs() {
    return Row(
      children: [
        _tabButton("Поиск по\nназванию", SearchMode.byName),
        const SizedBox(width: 15),
        _tabButton("Поиск по\nаниме", SearchMode.byAnime),
      ],
    );
  }

  Widget _tabButton(String text, SearchMode mode) {
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

  Widget _buildSearchInput() {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: 'Поиск...',
              hintStyle: const TextStyle(color: Colors.grey),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          _searchController.text = '';
                        });
                      },
                      icon: Image.asset(
                        'assets/icons/clear.png',
                        color: AppColors.primaryColor,
                        width: 15,
                        height: 15,
                      ),
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
            ),
            style: const TextStyle(color: AppColors.primaryColor),
            onChanged: (val) => setState(() {}),
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          onPressed: _showFilterDialog,
          icon: Image.asset(
            'assets/icons/filter.png',
            color: isDarkMode ? AppColors.secondary : AppColors.primaryColor,
            width: 30,
            height: 30,
          ),
        ),
      ],
    );
  }

  Widget _buildRecipeList(List<RecipeCardInfoEntity> recipes) {
    if (recipes.isEmpty) {
      return Center(
        child: Text(
          "Рецепты не найдены :(",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      );
    }
    return OrientationBuilder(
      builder: (ctx, orientation) {
        final isLandscape = orientation == Orientation.landscape;
        if (isLandscape) {
          return GridView.builder(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.zero,
            itemCount: recipes.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.2,
            ),
            itemBuilder: (context, index) => RecipeCard(recipe: recipes[index]),
          );
        } else {
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              return RecipeCard(recipe: recipes[index]);
            },
          );
        }
      },
    );
  }

  void _showFilterDialog() {
    final searchController = TextEditingController();
    final selectedIngredientIds = {..._filters.ingredientIds};

    // ШАГ 1: Запоминаем Future ОДИН раз перед открытием диалога.
    // Теперь при вызове setDialogState этот Future не будет создаваться заново!
    final ingredientsFuture = ref.read(ingredientsProvider.future);

    showDialog(
      context: context,
      builder: (context) {
        bool isDarkMode =
            MediaQuery.of(context).platformBrightness == Brightness.dark;
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: isDarkMode
                  ? AppColors.secondary
                  : AppColors.background,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "категории",
                        style: Theme.of(context).textTheme.headlineSmall!
                            .copyWith(
                              color: const Color(0xFF2D0C57),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 10),
                      _buildToggleGroup(
                        options: [
                          "Завтраки",
                          "Обеды",
                          "Ужины",
                          "Десерты",
                          "Напитки",
                        ],
                        selectedSet: _filters.categories,
                        onTap: (val) => setDialogState(() {
                          _filters.categories.contains(val)
                              ? _filters.categories.remove(val)
                              : _filters.categories.add(val);
                        }),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "сложность",
                        style: Theme.of(context).textTheme.headlineSmall!
                            .copyWith(
                              color: const Color(0xFF2D0C57),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 10),
                      _buildToggleGroup(
                        options: ["Легко", "Средне", "Сложно"],
                        selectedSet: _filters.levels,
                        onTap: (val) => setDialogState(() {
                          _filters.levels.contains(val)
                              ? _filters.levels.remove(val)
                              : _filters.levels.add(val);
                        }),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'ингредиенты',
                        style: Theme.of(context).textTheme.headlineSmall!
                            .copyWith(
                              color: const Color(0xFF2D0C57),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: 'Поиск ингредиентов',
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    searchController.clear();
                                    setDialogState(() {});
                                  },
                                )
                              : null,
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                        onChanged: (_) => setDialogState(() {}),
                      ),
                      const SizedBox(height: 8),

                      SizedBox(
                        height: 220,
                        child: FutureBuilder<List<IngredientEntity>>(
                          future:
                              ingredientsFuture, // Используем сохраненную переменную
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.hasError) {
                              return const Text(
                                'Не удалось загрузить ингредиенты',
                              );
                            }

                            final ingredients = snapshot.data ?? [];
                            final filteredIngredients = ingredients.where((
                              ingredient,
                            ) {
                              return ingredient.name.toLowerCase().contains(
                                searchController.text.toLowerCase(),
                              );
                            }).toList();

                            final selectedIngredients = selectedIngredientIds
                                .map(
                                  (id) => ingredients.firstWhere(
                                    (ingredient) => ingredient.id == id,
                                  ),
                                )
                                .toList();

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (selectedIngredients.isNotEmpty) ...[
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: selectedIngredients.map((
                                        ingredient,
                                      ) {
                                        return GestureDetector(
                                          onTap: () {
                                            setDialogState(() {
                                              selectedIngredientIds.remove(
                                                ingredient.id,
                                              );
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 8,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  ingredient.name,
                                                  style: TextStyle(
                                                    color: const Color(
                                                      0xFF2D0C57,
                                                    ),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Image.asset(
                                                  'assets/icons/clear.png',
                                                  width: 10,
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                        return InputChip(
                                          label: Text(ingredient.name),
                                          onDeleted: () {
                                            // Локальное обновление состояния внутри StatefulBuilder диалога
                                            setDialogState(() {
                                              selectedIngredientIds.remove(
                                                ingredient.id,
                                              );
                                            });
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                ],

                                Expanded(
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: false,
                                    physics: const ClampingScrollPhysics(),
                                    itemCount: filteredIngredients.length,
                                    itemBuilder: (context, index) {
                                      final ingredient =
                                          filteredIngredients[index];
                                      final isSelected = selectedIngredientIds
                                          .contains(ingredient.id);

                                      return CheckboxListTile(
                                        dense: true,
                                        contentPadding: EdgeInsets.zero,
                                        title: Text(ingredient.name),
                                        value: isSelected,
                                        activeColor: AppColors.secondary,
                                        onChanged: (selected) {
                                          // Локальное обновление чекбокса без перезапуска FutureBuilder
                                          setDialogState(() {
                                            if (selected == true) {
                                              selectedIngredientIds.add(
                                                ingredient.id,
                                              );
                                            } else {
                                              selectedIngredientIds.remove(
                                                ingredient.id,
                                              );
                                            }
                                          });
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2D0C57),
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 12,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _filters.ingredientIds
                          ..clear()
                          ..addAll(selectedIngredientIds);
                      });
                      Navigator.pop(context);
                    },
                    child: Text(
                      "применить",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  /*
  void _showFilterDialog() {
    final searchController = TextEditingController();

    final selectedIngredientIds = {..._filters.ingredientIds};
    showDialog(
      context: context,
      builder: (context) {
        bool isDarkMode =
            MediaQuery.of(context).platformBrightness == Brightness.dark;
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: isDarkMode
                  ? AppColors.secondary
                  : AppColors.background,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "категории",
                      style: Theme.of(context).textTheme.headlineSmall!
                          .copyWith(
                            color: Color(0xFF2D0C57),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 10),

                    _buildToggleGroup(
                      options: [
                        "Завтраки",
                        "Обеды",
                        "Ужины",
                        "Десерты",
                        "Напитки",
                      ],
                      selectedSet: _filters.categories,
                      onTap: (val) => setDialogState(() {
                        _filters.categories.contains(val)
                            ? _filters.categories.remove(val)
                            : _filters.categories.add(val);
                      }),
                    ),

                    const SizedBox(height: 20),
                    Text(
                      "сложность",
                      style: Theme.of(context).textTheme.headlineSmall!
                          .copyWith(
                            color: Color(0xFF2D0C57),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 10),

                    _buildToggleGroup(
                      options: ["Легко", "Средне", "Сложно"],
                      selectedSet: _filters.levels,
                      onTap: (val) => setDialogState(() {
                        _filters.levels.contains(val)
                            ? _filters.levels.remove(val)
                            : _filters.levels.add(val);
                      }),
                    ),
                    const SizedBox(height: 16),

                    Text(
                      'Ингредиенты',
                      style: Theme.of(context).textTheme.headlineSmall!
                          .copyWith(
                            color: Color(0xFF2D0C57),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                    ),

                    const SizedBox(height: 8),

                    TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Поиск ингредиентов',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  searchController.clear();
                                  setDialogState(() {});
                                },
                              )
                            : null,
                        border: const OutlineInputBorder(),
                      ),
                      onChanged: (_) => setDialogState(() {}),
                    ),

                    const SizedBox(height: 8),

                    FutureBuilder<List<IngredientEntity>>(
                      future: ref.read(ingredientsProvider.future),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (snapshot.hasError) {
                          return const Text('Не удалось загрузить ингредиенты');
                        }

                        final ingredients = snapshot.data ?? [];

                        final filteredIngredients = ingredients.where((
                          ingredient,
                        ) {
                          return ingredient.name.toLowerCase().contains(
                            searchController.text.toLowerCase(),
                          );
                        }).toList();

                        final selectedIngredients = ingredients
                            .where(
                              (ingredient) =>
                                  selectedIngredientIds.contains(ingredient.id),
                            )
                            .toList();

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (selectedIngredients.isNotEmpty) ...[
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: selectedIngredients.map((ingredient) {
                                  return InputChip(
                                    label: Text(ingredient.name),
                                    onDeleted: () {
                                      setDialogState(() {
                                        selectedIngredientIds.remove(
                                          ingredient.id,
                                        );
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 12),
                            ],

                            Column(
                              children: filteredIngredients.map((ingredient) {
                                final isSelected = selectedIngredientIds
                                    .contains(ingredient.id);

                                return CheckboxListTile(
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(ingredient.name),
                                  value: isSelected,
                                  activeColor: AppColors.secondary,
                                  onChanged: (selected) {
                                    setDialogState(() {
                                      if (selected == true) {
                                        selectedIngredientIds.add(
                                          ingredient.id,
                                        );
                                      } else {
                                        selectedIngredientIds.remove(
                                          ingredient.id,
                                        );
                                      }
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2D0C57),
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 12,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _filters.ingredientIds
                          ..clear()
                          ..addAll(selectedIngredientIds);
                      });
                      Navigator.pop(context);
                    },
                    child: Text(
                      "применить",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
*/

  Widget _buildToggleGroup({
    required List<String> options,
    required Set<String> selectedSet,
    required Function(String) onTap,
  }) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((option) {
        final isSelected = selectedSet.contains(option);
        return GestureDetector(
          onTap: () => onTap(option),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF2D0C57) : Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              option,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF2D0C57),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
