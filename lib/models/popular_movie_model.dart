class PopularMovieModel {
  final String? backdropPath;
  final int id;
  final String originalTitle;
  final double popularity;
  final String posterPath;
  final String title;

  PopularMovieModel({
    this.backdropPath,
    required this.id,
    required this.originalTitle,
    required this.popularity,
    required this.posterPath,
    required this.title,
  });
}
