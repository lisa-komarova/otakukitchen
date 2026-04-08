class RecipeSectionEntity {
  final String title; 
  final List<RecipeStepEntity> steps;

  RecipeSectionEntity({required this.title, required this.steps});
}

class RecipeStepEntity {
  final int stepNumber;
  final String description;

  RecipeStepEntity({
    required this.stepNumber,
    required this.description,
  });
}
