class IngredientGroupEntity {
  final String title;
  final List<IngredientEntity> ingredients;

  const IngredientGroupEntity({required this.title, required this.ingredients});
}


class IngredientEntity {
  final int id;
  final String name;      // displayName from IngredientInRecipe
  final String amount;    // quantity + unit
  final String? note;     

  const IngredientEntity({
    required this.id,
    required this.name,
    required this.amount,
    this.note,
  });
}
