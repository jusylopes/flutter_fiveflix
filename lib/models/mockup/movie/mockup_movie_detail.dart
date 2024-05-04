import 'package:flutter_fiveflix/models/movie_detail_model.dart';

abstract class MockupMovieDetail {
  static List<MovieDetailModel> movieDetail() {
    return [
      MovieDetailModel(
          backdropPath: '/di47xqYMCYpjqwnqNlO17X5qXMX.jpg',
          genres: [
            Genre(id: 35, name: "Comedy"),
            Genre(id: 80, name: "Crime"),
          ],
          id: 12153,
          imdbId: "tt0381707",
          overview:
              "Two FBI agent brothers, Marcus and Kevin Copeland, accidentally foil a drug bust. To avoid being fired they accept a mission escorting a pair of socialites to the Hamptons--but when the girls are disfigured in a car accident, they refuse to go. Left without options, Marcus and Kevin decide to pose as the sisters, transforming themselves from black men into rich white women.",
          popularity: 143.356,
          posterPath: "/aHTUpo45qy9QYIOnVITGGqLoVcA.jpg",
          releaseDate: DateTime.parse("2004-06-23"),
          title: "White Chicks",
          voteAverage: 6.951),
      
    ];
  }

  static MovieDetailModel getMovieById(int id) {
    return movieDetail().firstWhere((movie) => movie.id == id);
  }
}
