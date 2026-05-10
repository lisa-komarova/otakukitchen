enum SearchMode {
  byName,
  byAnime;

  String get label => this == SearchMode.byName ? 'по названию' : 'по аниме';
}
