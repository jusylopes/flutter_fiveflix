class PopularSerieModel {
  final String? backdropPath;
  final int id;
  final String originalName;
  final double popularity;
  final String posterPath;
  final String name;

  PopularSerieModel({
    this.backdropPath,
    required this.id,
    required this.originalName,
    required this.popularity,
    required this.posterPath,
    required this.name,
  });
}
