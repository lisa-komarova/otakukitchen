class Anime {
  final int id;
  final String title;
  final String? sceneDescription;
  final String? episode;

  const Anime({
    required this.id,
    required this.title,
    this.sceneDescription,
    this.episode,
  });

  factory Anime.fromMap(Map<String, dynamic> map) {
    return Anime(
      id: map['id'] as int,
      title: map['title'] as String? ?? '',
      sceneDescription: map['scene_description'] as String?,
      episode: map['episode'] as String?,
    );
  }
}
