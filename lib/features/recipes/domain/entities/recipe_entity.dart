// domain/entities/recipe_entity.dart

import 'package:otakukitchen/features/recipes/domain/entities/anime_entity.dart';
import 'package:otakukitchen/features/recipes/domain/entities/category_entity.dart';
import 'package:otakukitchen/features/recipes/domain/entities/ingredient_group_entity.dart';
import 'package:otakukitchen/features/recipes/domain/entities/recipe_section_entity.dart';

class RecipeEntity {
  final int id;
  final String name;
  final String cookingTime;
  final String level;
  final String imageUrl;
  final String? tiktokUrl;
  final String? telegramUrl;
  final bool isFavourite;
  final String? note;
  final CategoryEntity category;
  final List<AnimeEntity> animes;
  final List<IngredientGroupEntity> ingredientGroups;
  final List<RecipeSectionEntity> sections;

  RecipeEntity({
    required this.id,
    required this.name,
    required this.cookingTime,
    required this.level,
    required this.imageUrl,
    this.tiktokUrl,
    this.telegramUrl,
    required this.isFavourite,
    this.note,
    required this.category,
    required this.animes,
    required this.ingredientGroups,
    required this.sections,
  });
}
