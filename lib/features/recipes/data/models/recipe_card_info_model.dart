class RecipeCardInfoModel {
  final int id;
  final String name;
  final String cookingTime;
  final String imageUrl;
  final String animeTitle;

  const RecipeCardInfoModel({
    required this.id,
    required this.name,
    required this.cookingTime,
    required this.imageUrl,
    required this.animeTitle,
  });

  factory RecipeCardInfoModel.fromMap(Map<String, dynamic> map) {
    return RecipeCardInfoModel(
      id: map['id'] as int,
      name: map['name'] as String? ?? '',
      cookingTime: map['cooking_time'] as String? ?? '',
      imageUrl: map['image_url'] as String? ?? '',
      animeTitle: map['title'] as String? ?? '',
    );
  }

}
