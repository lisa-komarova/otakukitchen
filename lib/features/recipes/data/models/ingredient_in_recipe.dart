class IngredientInRecipe {
  final int id;
  final int groupId;
  final int ingredientId;
  final String displayName;
  final String? quantity;
  final String? unit;
  final String? note;

  const IngredientInRecipe({
    required this.id,
    required this.groupId,
    required this.ingredientId,
    required this.displayName,
    this.quantity,
    this.unit,
    this.note,
  });

  factory IngredientInRecipe.fromMap(Map<String, dynamic> map) {
    return IngredientInRecipe(
      id: map['id'] as int,
      groupId: map['group_id'] as int,
      ingredientId: map['ingredient_id'] as int,
      displayName: map['display_name'] as String? ?? '',
      quantity: map['quantity'] as String?,
      unit: map['unit'] as String?,
      note: map['note'] as String?,
    );
  }
}
