import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otakukitchen/core/theme.dart';
import 'package:otakukitchen/features/recipes/domain/entities/category_entity.dart';
import 'package:otakukitchen/features/recipes/presentation/pages/recipes_page.dart';
import 'package:otakukitchen/features/recipes/presentation/providers/categories_provider.dart';

class CategoriesPage extends ConsumerWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
     bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final categoriesAsync = ref.watch(categoriesProvider);

    return Scaffold(
      backgroundColor: isDarkMode
          ? AppColors.primaryColor
          : AppColors.background,
      body: categoriesAsync.when(
        data: (categories) => Padding(
          padding: const EdgeInsets.fromLTRB(15, 70, 15, 0),
          child: Column(
            children: categories.map((category) {
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: AppColors.cardColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: _buildCategoryCard(category, context),
                ),
              );
            }).toList(),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Ошибка: $err')),
      ),
    );
  }

  Widget _buildCategoryCard(CategoryEntity category, BuildContext context) {
    return InkWell(
       onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipesPage(category: category),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  category.name,
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
            Image.asset(
              'assets/icons/${category.icon}.png',
              width: 100,
              height: 100,
              color: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
