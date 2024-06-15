enum WidgetKeys {
  moviesCard,
  newsCard,
  gamesCard,
  favoritesCard,
  favoriteButton,
  favoriteRemoveIcon,
  searchIcon,
  searchTile,
  newsScreenIcon,
  homeScreenIcon,
  gamesScreenIcon,
  favoritesScreenIcon,
  favoriteCountBadge
}

extension WidgetKeysExtension on WidgetKeys {
  String get key => toString().split('.').last;
}
