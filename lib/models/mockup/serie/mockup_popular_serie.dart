import 'package:flutter_fiveflix/models/popular_serie_model.dart';

abstract class MockupPopularSerie {
  static List<PopularSerieModel> mockPopularSerie() {
    return [
      PopularSerieModel(
          id: 1,
          originalName: "originalName",
          popularity: 1,
          posterPath: "posterPath",
          name: "name")
    ];
  }

  static List<PopularSerieModel> getPopularMoviesSortedByPopularity() {
    List<PopularSerieModel> movies = mockPopularSerie();
    movies.sort((a, b) => b.popularity.compareTo(a.popularity));

    return movies;
  }
}
