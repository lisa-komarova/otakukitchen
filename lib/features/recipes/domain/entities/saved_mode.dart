enum SavedMode {
  favourite,
  cooked;

  String get label =>
      this == SavedMode.favourite ? 'избранное' : 'приготовлено';
}
