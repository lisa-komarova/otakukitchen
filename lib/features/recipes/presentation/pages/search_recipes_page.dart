import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otakukitchen/core/theme.dart';
import 'package:otakukitchen/features/recipes/domain/entities/recipe_entity.dart';
import 'package:otakukitchen/features/recipes/domain/entities/search_mode.dart';
import 'package:otakukitchen/features/recipes/presentation/providers/search_providers/search_recipes_provider.dart';
import 'package:otakukitchen/features/recipes/presentation/widgets/recipe_card.dart';

class SearchRecipesPage extends ConsumerStatefulWidget {
  const SearchRecipesPage({super.key});

  @override
  ConsumerState<SearchRecipesPage> createState() => _SearchRecipesPageState();
}

class _SearchRecipesPageState extends ConsumerState<SearchRecipesPage> {
  final TextEditingController _searchController = TextEditingController();
  SearchMode _currentMode = SearchMode.byName;
  final ({Set<String> categories, Set<String> levels}) _filters = (
    categories: {},
    levels: {},
  );
  @override
  Widget build(BuildContext context) {
    final Map<String, String> difficultyMapping = {
      "легко": "easy",
      "средне": "medium",
      "сложно": "hard",
    };
    final searchAsync = ref.watch(
      searchRecipesProvider(
        query: _searchController.text,
        mode: _currentMode,
        categories: _filters.categories.map((c) => "'$c'").join(','),
        levels: _filters.levels
            .map((d) => "'${difficultyMapping[d] ?? d}'")
            .join(','),
      ),
    );
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
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
    );
  }

  Widget _buildSearchTabs() {
    return Row(
      children: [
        _tabButton("поиск по\nназванию", SearchMode.byName),
        const SizedBox(width: 15),
        _tabButton("поиск по\nаниме", SearchMode.byAnime),
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

  Widget _buildRecipeList(List<RecipeEntity> recipes) {
    if (recipes.isEmpty) {
      return Center(
        child: Text(
          "Рецепты не найдены :(",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        return RecipeCard(recipe: recipes[index]);
      },
    );
  }

  void _showFilterDialog() {
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
                      options: ["легко", "средне", "сложно"],
                      selectedSet: _filters.levels,
                      onTap: (val) => setDialogState(() {
                        _filters.levels.contains(val)
                            ? _filters.levels.remove(val)
                            : _filters.levels.add(val);
                      }),
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
                      setState(() {});
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
