class MovieDetailModel {
  final String backdropPath;
  final List<GenreMovie> genres;
  final int id;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final int runtime;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  MovieDetailModel({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.runtime,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  MovieDetailModel copyWith({
    String? backdropPath,
    List<GenreMovie>? genres,
    int? id,
    String? originalTitle,
    String? overview,
    double? popularity,
    String? posterPath,
    DateTime? releaseDate,
    int? runtime,
    String? title,
    bool? video,
    double? voteAverage,
    int? voteCount,
  }) =>
      MovieDetailModel(
        backdropPath: backdropPath ?? this.backdropPath,
        genres: genres ?? this.genres,
        id: id ?? this.id,
        originalTitle: originalTitle ?? this.originalTitle,
        overview: overview ?? this.overview,
        popularity: popularity ?? this.popularity,
        posterPath: posterPath ?? this.posterPath,
        releaseDate: releaseDate ?? this.releaseDate,
        runtime: runtime ?? this.runtime,
        title: title ?? this.title,
        video: video ?? this.video,
        voteAverage: voteAverage ?? this.voteAverage,
        voteCount: voteCount ?? this.voteCount,
      );

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) =>
      MovieDetailModel(
        backdropPath: json["backdrop_path"],
        genres: List<GenreMovie>.from(json["genres"].map((x) => GenreMovie.fromJson(x))),
        id: json["id"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        releaseDate: DateTime.parse(json["release_date"]),
        runtime: json["runtime"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "id": id,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "runtime": runtime,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}

class GenreMovie {
  final int id;
  final String name;

  GenreMovie({
    required this.id,
    required this.name,
  });

  GenreMovie copyWith({
    int? id,
    String? name,
  }) =>
      GenreMovie(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory GenreMovie.fromJson(Map<String, dynamic> json) => GenreMovie(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

