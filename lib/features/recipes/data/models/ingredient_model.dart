class IngredientModel {
  final int id;
  final String name;
  final String amount;

  const IngredientModel({
    required this.id,
    required this.name,
    required this.amount,
  });

  factory IngredientModel.fromMap(Map<String, dynamic> map) {
    return IngredientModel(
      id: map['id'] as int,
      name: map['name'] as String? ?? '',
      amount: map['amount'] as String? ?? '',
    );
  }
}
