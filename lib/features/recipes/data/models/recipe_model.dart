class Recipe {
  final int id;
  final String name;
  final String cookingTime;
  final String level;
  final int categoryId;
  final String imageUrl;
  final String? tiktokUrl;
  final String? telegramUrl;
  final bool isFavourite;
  final String? note;

  const Recipe({
    required this.id,
    required this.name,
    required this.cookingTime,
    required this.level,
    required this.categoryId,
    required this.imageUrl,
    this.tiktokUrl,
    this.telegramUrl,
    required this.isFavourite,
    this.note,
  });

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'] as int,
      name: map['name'] as String? ?? '',
      cookingTime: map['cooking_time'] as String? ?? '',
      level: map['level'] as String? ?? '',
      categoryId: map['category_id'] as int? ?? 0,
      imageUrl: map['image_url'] as String? ?? '',
      tiktokUrl: map['tiktok_url'] as String?,
      telegramUrl: map['telegram_url'] as String?,
      isFavourite: (map['is_favourite'] as int? ?? 0) == 1,
      note: map['note'] as String?,
    );
  }

}
