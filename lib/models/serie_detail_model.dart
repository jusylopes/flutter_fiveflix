import 'dart:convert';

SerieDetailModel movieDetailModelFromJson(String str) => SerieDetailModel.fromJson(json.decode(str));

String movieDetailModelToJson(SerieDetailModel data) => json.encode(data.toJson());

class SerieDetailModel {
    final String backdropPath;
    final List<CreatedBy> createdBy;
    final DateTime firstAirDate;
    final List<Genre> genres;
    final int id;
    final String name;
    final int numberOfEpisodes;
    final int numberOfSeasons;
    final List<String> originCountry;
    final String originalLanguage;
    final String originalName;
    final String overview;
    final double popularity;
    final String posterPath;
    final double voteAverage;
    final int voteCount;

    SerieDetailModel({
        required this.backdropPath,
        required this.createdBy,
        required this.firstAirDate,
        required this.genres,
        required this.id,
        required this.name,
        required this.numberOfEpisodes,
        required this.numberOfSeasons,
        required this.originCountry,
        required this.originalLanguage,
        required this.originalName,
        required this.overview,
        required this.popularity,
        required this.posterPath,
        required this.voteAverage,
        required this.voteCount,
    });

    SerieDetailModel copyWith({
        String? backdropPath,
        List<CreatedBy>? createdBy,
        DateTime? firstAirDate,
        List<Genre>? genres,
        String? homepage,
        int? id,
        String? name,
        int? numberOfEpisodes,
        int? numberOfSeasons,
        List<String>? originCountry,
        String? originalLanguage,
        String? originalName,
        String? overview,
        double? popularity,
        String? posterPath,
        double? voteAverage,
        int? voteCount,
    }) => 
        SerieDetailModel(
            backdropPath: backdropPath ?? this.backdropPath,
            createdBy: createdBy ?? this.createdBy,
            firstAirDate: firstAirDate ?? this.firstAirDate,
            genres: genres ?? this.genres,
            id: id ?? this.id,
            name: name ?? this.name,
            numberOfEpisodes: numberOfEpisodes ?? this.numberOfEpisodes,
            numberOfSeasons: numberOfSeasons ?? this.numberOfSeasons,
            originCountry: originCountry ?? this.originCountry,
            originalLanguage: originalLanguage ?? this.originalLanguage,
            originalName: originalName ?? this.originalName,
            overview: overview ?? this.overview,
            popularity: popularity ?? this.popularity,
            posterPath: posterPath ?? this.posterPath,
            voteAverage: voteAverage ?? this.voteAverage,
            voteCount: voteCount ?? this.voteCount,
        );

    factory SerieDetailModel.fromJson(Map<String, dynamic> json) => SerieDetailModel(
        backdropPath: json["backdrop_path"],
        createdBy: List<CreatedBy>.from(json["created_by"].map((x) => CreatedBy.fromJson(x))),
        firstAirDate: DateTime.parse(json["first_air_date"]),
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        id: json["id"],
        name: json["name"],
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
    );

    Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "created_by": List<dynamic>.from(createdBy.map((x) => x.toJson())),
        "first_air_date": "${firstAirDate.year.toString().padLeft(4, '0')}-${firstAirDate.month.toString().padLeft(2, '0')}-${firstAirDate.day.toString().padLeft(2, '0')}",
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "id": id,
        "name": name,
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
    };
}

class CreatedBy {
    final int id;
    final String creditId;
    final String name;
    final String originalName;
    final int gender;
    final String profilePath;

    CreatedBy({
        required this.id,
        required this.creditId,
        required this.name,
        required this.originalName,
        required this.gender,
        required this.profilePath,
    });

    CreatedBy copyWith({
        int? id,
        String? creditId,
        String? name,
        String? originalName,
        int? gender,
        String? profilePath,
    }) => 
        CreatedBy(
            id: id ?? this.id,
            creditId: creditId ?? this.creditId,
            name: name ?? this.name,
            originalName: originalName ?? this.originalName,
            gender: gender ?? this.gender,
            profilePath: profilePath ?? this.profilePath,
        );

    factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json["id"],
        creditId: json["credit_id"],
        name: json["name"],
        originalName: json["original_name"],
        gender: json["gender"],
        profilePath: json["profile_path"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "credit_id": creditId,
        "name": name,
        "original_name": originalName,
        "gender": gender,
        "profile_path": profilePath,
    };
}

class Genre {
    final int id;
    final String name;

    Genre({
        required this.id,
        required this.name,
    });

    Genre copyWith({
        int? id,
        String? name,
    }) => 
        Genre(
            id: id ?? this.id,
            name: name ?? this.name,
        );

    factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}


class ProductionCountry {
    final String iso31661;
    final String name;

    ProductionCountry({
        required this.iso31661,
        required this.name,
    });

    ProductionCountry copyWith({
        String? iso31661,
        String? name,
    }) => 
        ProductionCountry(
            iso31661: iso31661 ?? this.iso31661,
            name: name ?? this.name,
        );

    factory ProductionCountry.fromJson(Map<String, dynamic> json) => ProductionCountry(
        iso31661: json["iso_3166_1"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "iso_3166_1": iso31661,
        "name": name,
    };
}

class Season {
    final DateTime? airDate;
    final int episodeCount;
    final int id;
    final String name;
    final String overview;
    final String posterPath;
    final int seasonNumber;
    final double voteAverage;

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

    Season copyWith({
        DateTime? airDate,
        int? episodeCount,
        int? id,
        String? name,
        String? overview,
        String? posterPath,
        int? seasonNumber,
        double? voteAverage,
    }) => 
        Season(
            airDate: airDate ?? this.airDate,
            episodeCount: episodeCount ?? this.episodeCount,
            id: id ?? this.id,
            name: name ?? this.name,
            overview: overview ?? this.overview,
            posterPath: posterPath ?? this.posterPath,
            seasonNumber: seasonNumber ?? this.seasonNumber,
            voteAverage: voteAverage ?? this.voteAverage,
        );

    factory Season.fromJson(Map<String, dynamic> json) => Season(
        airDate: json["air_date"] == null ? null : DateTime.parse(json["air_date"]),
        episodeCount: json["episode_count"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
        voteAverage: json["vote_average"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "air_date": "${airDate!.year.toString().padLeft(4, '0')}-${airDate!.month.toString().padLeft(2, '0')}-${airDate!.day.toString().padLeft(2, '0')}",
        "episode_count": episodeCount,
        "id": id,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
        "season_number": seasonNumber,
        "vote_average": voteAverage,
    };
}


