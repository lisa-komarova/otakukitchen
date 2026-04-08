class Ingredient {
  final int id;
  final String name;

  const Ingredient({required this.id, required this.name});

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(id: map['id'] as int, name: map['name'] as String? ?? '');
  }
}
