class AnimeEntity {
   final int id;
  final String title;
  final String? sceneDescription;
  final String? episode;

  AnimeEntity({
    required this.id,
    required this.title,
    this.sceneDescription,
    this.episode,
  });
}
