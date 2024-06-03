import 'package:hive/hive.dart';

class MediaModel {
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String overview;
  final double popularity;
  final String posterPath;
  final double voteAverage;
  final int voteCount;
  final String? originalTitle;
  final DateTime? releaseDate;
  final String? title;
  final String? originalName;
  final DateTime? firstAirDate;
  final String? name;

  MediaModel({
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
    this.originalTitle,
    this.releaseDate,
    this.title,
    this.originalName,
    this.firstAirDate,
    this.name,
  });

  MediaModel copyWith({
    String? backdropPath,
    List<int>? genreIds,
    int? id,
    String? overview,
    double? popularity,
    String? posterPath,
    double? voteAverage,
    int? voteCount,
    String? originalTitle,
    DateTime? releaseDate,
    String? title,
    String? originalName,
    DateTime? firstAirDate,
    String? name,
  }) =>
      MediaModel(
        backdropPath: backdropPath ?? this.backdropPath,
        genreIds: genreIds ?? this.genreIds,
        id: id ?? this.id,
        overview: overview ?? this.overview,
        popularity: popularity ?? this.popularity,
        posterPath: posterPath ?? this.posterPath,
        voteAverage: voteAverage ?? this.voteAverage,
        voteCount: voteCount ?? this.voteCount,
        originalTitle: originalTitle ?? this.originalTitle,
        releaseDate: releaseDate ?? this.releaseDate,
        title: title ?? this.title,
        originalName: originalName ?? this.originalName,
        firstAirDate: firstAirDate ?? this.firstAirDate,
        name: name ?? this.name,
      );

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return MediaModel(
      backdropPath: json["backdrop_path"],
      genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
      id: json["id"],
      overview: json["overview"],
      popularity: json["popularity"]?.toDouble(),
      posterPath: json["poster_path"],
      voteAverage: json["vote_average"]?.toDouble(),
      voteCount: json["vote_count"],
      originalTitle: json["original_title"],
      releaseDate: json["release_date"] != null
          ? DateTime.parse(json["release_date"])
          : null,
      title: json["title"],
      originalName: json["original_name"],
      firstAirDate: json["first_air_date"] != null
          ? DateTime.parse(json["first_air_date"])
          : null,
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "original_title": originalTitle,
        "release_date": releaseDate != null
            ? "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}"
            : null,
        "title": title,
        "original_name": originalName,
        "first_air_date": firstAirDate != null
            ? "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}"
            : null,
        "name": name,
      };

  bool get isMovie => title != null && title!.isNotEmpty;
  bool get isSeries => name != null && name!.isNotEmpty;
}

class MediaModelAdapter extends TypeAdapter<MediaModel> {
  @override
  final int typeId = 2;

  @override
  MediaModel read(BinaryReader reader) {
    final backdropPath = reader.readString();
    final genreIds = (reader.readList()).cast<int>();
    final id = reader.readInt();
    final overview = reader.readString();
    final popularity = reader.readDouble();
    final posterPath = reader.readString();
    final voteAverage = reader.readDouble();
    final voteCount = reader.readInt();
    final releaseDate = reader.read() as DateTime?;
    final title = reader.readString();
    final firstAirDate = reader.read() as DateTime?;
    final name = reader.readString();

    return MediaModel(
      backdropPath: backdropPath,
      genreIds: genreIds,
      id: id,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      voteAverage: voteAverage,
      voteCount: voteCount,
      releaseDate: releaseDate,
      title: title,
      firstAirDate: firstAirDate,
      name: name,
    );
  }

  @override
  void write(BinaryWriter writer, MediaModel obj) {
    writer.writeString(obj.backdropPath ?? obj.posterPath);
    writer.writeList(obj.genreIds);
    writer.writeInt(obj.id);
    writer.writeString(obj.overview);
    writer.writeDouble(obj.popularity);
    writer.writeString(obj.posterPath);
    writer.writeDouble(obj.voteAverage);
    writer.writeInt(obj.voteCount);
    writer.write(obj.releaseDate ?? obj.firstAirDate);
    writer.writeString(obj.title ?? '');
    writer.write(obj.firstAirDate ?? obj.releaseDate);
    writer.writeString(obj.name ?? '');
  }
}

enum MediaType { movie, serie }
