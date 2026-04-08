import 'package:otakukitchen/features/recipes/domain/entities/recipe_section_entity.dart';
import 'package:otakukitchen/features/recipes/data/models/recipe_section.dart';
import 'package:otakukitchen/features/recipes/data/models/step.dart';

class RecipeSectionMapper {
  static List<RecipeSectionEntity> mapSections(
    List<RecipeSection> sections,
    List<Step> steps,
  ) {
    final sortedSections = List<RecipeSection>.from(sections)
      ..sort((a, b) => a.orderIndex.compareTo(b.orderIndex));

    return sortedSections.map((section) {
      final sectionSteps =
          steps.where((s) => s.sectionId == section.id).toList()
            ..sort((a, b) => a.orderIndex.compareTo(b.orderIndex));

      return RecipeSectionEntity(
        title: section.title,
        steps: sectionSteps.asMap().entries.map((entry) {
          final index = entry.key;
          final step = entry.value;

          return RecipeStepEntity(
            stepNumber: index + 1,
            description: step.description,
          );
        }).toList(),
      );
    }).toList();
  }
}
