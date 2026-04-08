class Category {
  final int id;
  final String name;
  final String icon;

  const Category({required this.id, required this.name, required this.icon});

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as int,
      name: map['name'] as String? ?? '',
      icon: map['icon'] as String? ?? '',
    );
  }
}
