class CategoryModel {
  final int id;
  final String name;
  final String icon;

  const CategoryModel({required this.id, required this.name, required this.icon});

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as int,
      name: map['name'] as String? ?? '',
      icon: map['icon'] as String? ?? '',
    );
  }
}
