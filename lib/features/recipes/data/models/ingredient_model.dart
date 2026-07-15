class IngredientModel {
  final int id;
  final String name;

  const IngredientModel({required this.id, required this.name});

  factory IngredientModel.fromMap(Map<String, dynamic> map) {
    return IngredientModel(id: map['id'] as int, name: map['name'] as String? ?? '');
  }
}
