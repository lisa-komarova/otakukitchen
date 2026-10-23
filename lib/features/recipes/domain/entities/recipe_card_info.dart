
class RecipeCardInfoEntity {
  final int id;
  final String name;
  final String cookingTime;
  final String imageUrl;
  final String animeTitle;

  RecipeCardInfoEntity({
    required this.id,
    required this.name,
    required this.cookingTime,
    required this.imageUrl,
    required this.animeTitle,
  });
  RecipeCardInfoEntity copyWith({
    int? id,
    String? name,
    String? cookingTime,
    String? imageUrl,
    String? animeTitle,
  }) {
    return RecipeCardInfoEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      cookingTime: cookingTime ?? this.cookingTime,
      imageUrl: imageUrl ?? this.imageUrl,
      animeTitle: animeTitle ?? this.animeTitle,
    );
  }
}
