class SerieDetailModel {
  final String backdropPath;
  final List<Genre> genres;
  final int id;
  final int numberOfSeasons;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final String name;
  final double voteAverage;
  final List<Season> seasons;

  SerieDetailModel({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.numberOfSeasons,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.name,
    required this.voteAverage,
    required this.seasons,
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

class Season {
  final DateTime airDate;
  final int episodeCount;
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final int seasonNumber;
  final int voteAverage;

  Season({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });
}
