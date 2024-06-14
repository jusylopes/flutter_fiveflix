enum WidgetKeys {
  tabPopularMovies,
  popularMovieScreen,
  cardMovies,
  cardNewsMovies,
  cardFavorites,
  cardGames,
  iconSearch,
  mediaTileSearch,
  favoriteButton,
  iconNews,
  iconGames,
  iconFavorites,
}

extension WidgetKeysExtension on WidgetKeys {
  String get key => toString().split('.').last;
}
