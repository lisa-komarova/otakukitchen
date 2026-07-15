class IngredientGroupModel {
  final int id;
  final int recipeId;
  final String title;
  final int orderIndex;

  const IngredientGroupModel({
    required this.id,
    required this.recipeId,
    required this.title,
    required this.orderIndex,
  });

  factory IngredientGroupModel.fromMap(Map<String, dynamic> map) {
    return IngredientGroupModel(
      id: map['id'] as int,
      recipeId: map['recipe_id'] as int,
      title: map['title'] as String? ?? '',
      orderIndex: map['order_index'] as int? ?? 0,
    );
  }
}
