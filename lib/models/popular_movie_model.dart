class PopularMovieModel {
  final String? backdropPath;
  final int id;
  final String originalTitle;
  final double popularity;
  final String posterPath;
  final String title;
  final List<Genre> genres;

  PopularMovieModel(
      {this.backdropPath,
      required this.id,
      required this.originalTitle,
      required this.popularity,
      required this.posterPath,
      required this.title,
      required this.genres});
}

class Genre {
  final int id;
  final String name;

  Genre({
    required this.id,
    required this.name,
  });
}
