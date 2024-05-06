class MovieDetailModel {
  final String backdropPath;
  final List<Genre> genres;
  final int id;
  final String imdbId;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final String title;
  final double voteAverage;

  MovieDetailModel({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.imdbId,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
  });
}

class Genre {
  final int id;
  final String name;

  Genre({
    required this.id,
    required this.name,
  });
}
