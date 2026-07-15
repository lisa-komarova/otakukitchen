class AnimeModel {
  final int id;
  final String title;
  final String? sceneDescription;
  final String? episode;

  const AnimeModel({
    required this.id,
    required this.title,
    this.sceneDescription,
    this.episode,
  });

  factory AnimeModel.fromMap(Map<String, dynamic> map) {
    return AnimeModel(
      id: map['id'] as int,
      title: map['title'] as String? ?? '',
      sceneDescription: map['scene_description'] as String?,
      episode: map['episode'] as String?,
    );
  }
}
