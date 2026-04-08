import 'package:flutter_test/flutter_test.dart';
import 'package:otakukitchen/features/recipes/data/models/anime_model.dart';
import 'package:otakukitchen/features/recipes/data/models/category_model.dart';
import 'package:otakukitchen/features/recipes/data/models/ingredient_group.dart';
import 'package:otakukitchen/features/recipes/data/models/ingredient_in_recipe.dart';
import 'package:otakukitchen/features/recipes/data/models/ingredient_model.dart';
import 'package:otakukitchen/features/recipes/data/models/recipe_model.dart';
import 'package:otakukitchen/features/recipes/data/models/recipe_section.dart';
import 'package:otakukitchen/features/recipes/data/models/step.dart';

void main() {
  group('Anime.fromMap', () {
    test('should correctly parse full map', () {
      final map = {
        'id': 1,
        'title': 'Naruto',
        'scene_description': 'Eating ramen',
        'episode': 'Episode 1',
      };

      final anime = Anime.fromMap(map);

      expect(anime.id, 1);
      expect(anime.title, 'Naruto');
      expect(anime.sceneDescription, 'Eating ramen');
      expect(anime.episode, 'Episode 1');
    });

    test('should handle null optional fields', () {
      final map = {
        'id': 2,
        'title': 'One Piece',
        'scene_description': null,
        'episode': null,
      };

      final anime = Anime.fromMap(map);

      expect(anime.id, 2);
      expect(anime.title, 'One Piece');
      expect(anime.sceneDescription, isNull);
      expect(anime.episode, isNull);
    });

    test('should set empty string if title is null', () {
      final map = {
        'id': 3,
        'title': null,
        'scene_description': 'Some scene',
        'episode': 'Ep 5',
      };

      final anime = Anime.fromMap(map);

      expect(anime.id, 3);
      expect(anime.title, ''); // важно
      expect(anime.sceneDescription, 'Some scene');
      expect(anime.episode, 'Ep 5');
    });

    test('should throw if id is missing or not int', () {
      final map = {'title': 'Bleach'};

      expect(() => Anime.fromMap(map), throwsA(isA<TypeError>()));
    });
  });
  group('Category.fromMap', () {
    test('should correctly parse full map', () {
      final map = {'id': 1, 'name': 'Desserts', 'icon': 'cake'};

      final category = Category.fromMap(map);

      expect(category.id, 1);
      expect(category.name, 'Desserts');
      expect(category.icon, 'cake');
    });

    test('should set empty string if name and icon are null', () {
      final map = {'id': 2, 'name': null, 'icon': null};

      final category = Category.fromMap(map);

      expect(category.id, 2);
      expect(category.name, '');
      expect(category.icon, '');
    });

    test('should handle missing optional fields (name, icon)', () {
      final map = {'id': 3};

      final category = Category.fromMap(map);

      expect(category.id, 3);
      expect(category.name, '');
      expect(category.icon, '');
    });

    test('should throw if id is missing or not int', () {
      final map = {'name': 'Breakfast', 'icon': 'sun'};

      expect(() => Category.fromMap(map), throwsA(isA<TypeError>()));
    });
  });
  group('IngredientGroup.fromMap', () {
    test('should correctly parse full map', () {
      final map = {
        'id': 1,
        'recipe_id': 10,
        'title': 'Main ingredients',
        'order_index': 2,
      };

      final group = IngredientGroup.fromMap(map);

      expect(group.id, 1);
      expect(group.recipeId, 10);
      expect(group.title, 'Main ingredients');
      expect(group.orderIndex, 2);
    });

    test('should set default values for nullable fields', () {
      final map = {
        'id': 2,
        'recipe_id': 20,
        'title': null,
        'order_index': null,
      };

      final group = IngredientGroup.fromMap(map);

      expect(group.id, 2);
      expect(group.recipeId, 20);
      expect(group.title, '');
      expect(group.orderIndex, 0);
    });

    test('should handle missing optional fields (title, order_index)', () {
      final map = {'id': 3, 'recipe_id': 30};

      final group = IngredientGroup.fromMap(map);

      expect(group.id, 3);
      expect(group.recipeId, 30);
      expect(group.title, '');
      expect(group.orderIndex, 0);
    });

    test('should throw if required fields are missing or invalid', () {
      final map = {'title': 'Something'};

      expect(() => IngredientGroup.fromMap(map), throwsA(isA<TypeError>()));
    });
  });
  group('IngredientInRecipe.fromMap', () {
    test('should correctly parse full map', () {
      final map = {
        'id': 1,
        'group_id': 10,
        'ingredient_id': 100,
        'display_name': 'Sugar',
        'quantity': '2',
        'unit': 'tbsp',
        'note': 'optional',
      };

      final ingredient = IngredientInRecipe.fromMap(map);

      expect(ingredient.id, 1);
      expect(ingredient.groupId, 10);
      expect(ingredient.ingredientId, 100);
      expect(ingredient.displayName, 'Sugar');
      expect(ingredient.quantity, '2');
      expect(ingredient.unit, 'tbsp');
      expect(ingredient.note, 'optional');
    });

    test('should handle null optional fields', () {
      final map = {
        'id': 2,
        'group_id': 20,
        'ingredient_id': 200,
        'display_name': 'Salt',
        'quantity': null,
        'unit': null,
        'note': null,
      };

      final ingredient = IngredientInRecipe.fromMap(map);

      expect(ingredient.id, 2);
      expect(ingredient.groupId, 20);
      expect(ingredient.ingredientId, 200);
      expect(ingredient.displayName, 'Salt');
      expect(ingredient.quantity, isNull);
      expect(ingredient.unit, isNull);
      expect(ingredient.note, isNull);
    });

    test('should set empty string if displayName is null', () {
      final map = {
        'id': 3,
        'group_id': 30,
        'ingredient_id': 300,
        'display_name': null,
      };

      final ingredient = IngredientInRecipe.fromMap(map);

      expect(ingredient.id, 3);
      expect(ingredient.groupId, 30);
      expect(ingredient.ingredientId, 300);
      expect(ingredient.displayName, '');
      expect(ingredient.quantity, isNull);
      expect(ingredient.unit, isNull);
      expect(ingredient.note, isNull);
    });

    test('should throw if required fields are missing or invalid', () {
      final map = {'display_name': 'Milk'};

      expect(() => IngredientInRecipe.fromMap(map), throwsA(isA<TypeError>()));
    });
  });
  group('Ingredient.fromMap', () {
    test('should correctly parse full map', () {
      final map = {
        'id': 1,
        'name': 'Flour',
      };

      final ingredient = Ingredient.fromMap(map);

      expect(ingredient.id, 1);
      expect(ingredient.name, 'Flour');
    });

    test('should set empty string if name is null', () {
      final map = {
        'id': 2,
        'name': null,
      };

      final ingredient = Ingredient.fromMap(map);

      expect(ingredient.id, 2);
      expect(ingredient.name, '');
    });

    test('should handle missing optional field (name)', () {
      final map = {
        'id': 3,
      };

      final ingredient = Ingredient.fromMap(map);

      expect(ingredient.id, 3);
      expect(ingredient.name, '');
    });

    test('should throw if id is missing or not int', () {
      final map = {
        'name': 'Sugar',
      };

      expect(
        () => Ingredient.fromMap(map),
        throwsA(isA<TypeError>()),
      );
    });
  });
  group('Recipe.fromMap', () {
    test('should correctly parse full map', () {
      final map = {
        'id': 1,
        'name': 'Ramen',
        'cooking_time': '30 min',
        'level': 'Easy',
        'category_id': 2,
        'image_url': 'image.png',
        'tiktok_url': 'tiktok.com/video',
        'telegram_url': 't.me/recipe',
        'is_favourite': 1,
        'note': 'Best served hot',
      };

      final recipe = Recipe.fromMap(map);

      expect(recipe.id, 1);
      expect(recipe.name, 'Ramen');
      expect(recipe.cookingTime, '30 min');
      expect(recipe.level, 'Easy');
      expect(recipe.categoryId, 2);
      expect(recipe.imageUrl, 'image.png');
      expect(recipe.tiktokUrl, 'tiktok.com/video');
      expect(recipe.telegramUrl, 't.me/recipe');
      expect(recipe.isFavourite, true);
      expect(recipe.note, 'Best served hot');
    });

    test('should handle null and default values', () {
      final map = {
        'id': 2,
        'name': null,
        'cooking_time': null,
        'level': null,
        'category_id': null,
        'image_url': null,
        'tiktok_url': null,
        'telegram_url': null,
        'is_favourite': null,
        'note': null,
      };

      final recipe = Recipe.fromMap(map);

      expect(recipe.id, 2);
      expect(recipe.name, '');
      expect(recipe.cookingTime, '');
      expect(recipe.level, '');
      expect(recipe.categoryId, 0);
      expect(recipe.imageUrl, '');
      expect(recipe.tiktokUrl, isNull);
      expect(recipe.telegramUrl, isNull);
      expect(recipe.isFavourite, false);
      expect(recipe.note, isNull);
    });

    test('should convert is_favourite correctly', () {
      final mapTrue = {'id': 3, 'is_favourite': 1};

      final mapFalse = {'id': 4, 'is_favourite': 0};

      final recipeTrue = Recipe.fromMap(mapTrue);
      final recipeFalse = Recipe.fromMap(mapFalse);

      expect(recipeTrue.isFavourite, true);
      expect(recipeFalse.isFavourite, false);
    });

    test('should handle missing optional fields', () {
      final map = {'id': 5};

      final recipe = Recipe.fromMap(map);

      expect(recipe.id, 5);
      expect(recipe.name, '');
      expect(recipe.cookingTime, '');
      expect(recipe.level, '');
      expect(recipe.categoryId, 0);
      expect(recipe.imageUrl, '');
      expect(recipe.tiktokUrl, isNull);
      expect(recipe.telegramUrl, isNull);
      expect(recipe.isFavourite, false);
      expect(recipe.note, isNull);
    });

    test('should throw if id is missing or invalid', () {
      final map = {'name': 'Sushi'};

      expect(() => Recipe.fromMap(map), throwsA(isA<TypeError>()));
    });
  });

  group('RecipeSection.fromMap', () {
    test('should correctly parse full map', () {
      final map = {
        'id': 1,
        'recipe_id': 10,
        'title': 'Preparation',
        'order_index': 2,
      };

      final section = RecipeSection.fromMap(map);

      expect(section.id, 1);
      expect(section.recipeId, 10);
      expect(section.title, 'Preparation');
      expect(section.orderIndex, 2);
    });

    test('should set default values for nullable fields', () {
      final map = {
        'id': 2,
        'recipe_id': 20,
        'title': null,
        'order_index': null,
      };

      final section = RecipeSection.fromMap(map);

      expect(section.id, 2);
      expect(section.recipeId, 20);
      expect(section.title, '');
      expect(section.orderIndex, 0);
    });

    test('should handle missing optional fields (title, order_index)', () {
      final map = {'id': 3, 'recipe_id': 30};

      final section = RecipeSection.fromMap(map);

      expect(section.id, 3);
      expect(section.recipeId, 30);
      expect(section.title, '');
      expect(section.orderIndex, 0);
    });

    test('should throw if required fields are missing or invalid', () {
      final map = {'title': 'Cooking'};

      expect(() => RecipeSection.fromMap(map), throwsA(isA<TypeError>()));
    });
  });
  group('Step.fromMap', () {
    test('should correctly parse full map', () {
      final map = {
        'id': 1,
        'section_id': 10,
        'description': 'Chop the onions',
        'order_index': 2,
      };

      final step = Step.fromMap(map);

      expect(step.id, 1);
      expect(step.sectionId, 10);
      expect(step.description, 'Chop the onions');
      expect(step.orderIndex, 2);
    });

    test('should set default values for nullable fields', () {
      final map = {
        'id': 2,
        'section_id': 20,
        'description': null,
        'order_index': null,
      };

      final step = Step.fromMap(map);

      expect(step.id, 2);
      expect(step.sectionId, 20);
      expect(step.description, '');
      expect(step.orderIndex, 0);
    });

    test(
      'should handle missing optional fields (description, order_index)',
      () {
        final map = {'id': 3, 'section_id': 30};

        final step = Step.fromMap(map);

        expect(step.id, 3);
        expect(step.sectionId, 30);
        expect(step.description, '');
        expect(step.orderIndex, 0);
      },
    );

    test('should throw if required fields are missing or invalid', () {
      final map = {'description': 'Mix ingredients'};

      expect(() => Step.fromMap(map), throwsA(isA<TypeError>()));
    });
  });
}
