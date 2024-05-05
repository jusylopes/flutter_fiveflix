import 'package:flutter_fiveflix/models/serie_detail.dart';

abstract class MockupSerieDetail {
  static List<SerieDetailModel> serieDetail() {
    return [
      SerieDetailModel(
        backdropPath: "backdropPath",
        genres: [
          Genre(id: 1, name: ""),
        ],
        id: 1,
        numberOfSeasons: 1,
        overview: "overview",
        popularity: 1,
        posterPath: "posterPath",
        releaseDate: DateTime.parse("2004-06-23"),
        name: "name",
        voteAverage: 1,
        seasons: [
          Season(
              airDate: DateTime.parse("2004-06-23"),
              episodeCount: 1,
              id: 1,
              name: "name",
              overview: "overvie",
              posterPath: "posterPath",
              seasonNumber: 1,
              voteAverage: 1),
        ],
      ),
    ];
  }

  static SerieDetailModel getSerieById(int id) {
    return serieDetail().firstWhere((serie) => serie.id == id);
  }
}
