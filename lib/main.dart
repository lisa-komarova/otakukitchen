import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otakukitchen/core/recipe_database.dart';
import 'package:otakukitchen/core/theme.dart';
import 'package:otakukitchen/features/recipes/data/sources/database_provider.dart';
import 'package:otakukitchen/features/recipes/presentation/pages/recipe_details_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = await initDB('recipes.db');

  runApp(
    ProviderScope(
      overrides: [databaseProvider.overrideWithValue(db)],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const RecipeDetailsPage(recipeId: 9),
      ),
    ),
  );
}


