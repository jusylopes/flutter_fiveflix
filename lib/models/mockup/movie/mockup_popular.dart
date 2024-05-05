import 'package:flutter_fiveflix/models/popular_movie_model.dart';

abstract class MockupPopularMovie {
  static List<PopularMovieModel> mockPopularMovie() {
    return [
      PopularMovieModel(
        backdropPath: '/qrGtVFxaD8c7et0jUtaYhyTzzPg.jpg',
        id: 823464,
        originalTitle: "Godzilla x Kong: The New Empire",
        popularity: 1818.259,
        posterPath: "/tMefBSflR6PGQLv7WvFPpKLZkyk.jpg",
        title: "Godzilla x Kong: The New Empire",
        genres: [
          Genre(id: 28, name: "Action"),
          Genre(id: 878, name: "Science Fiction"),
          Genre(id: 12, name: "Adventure"),
        ],
      ),
      PopularMovieModel(
        backdropPath: '/jnE1GA7cGEfv5DJBoU2t4bZHaP4.jpg',
        id: 1094844,
        originalTitle: "Ape vs. Mecha Ape",
        popularity: 1639.584,
        posterPath: "/dJaIw8OgACelojyV6YuVsOhtTLO.jpg",
        title: "Ape vs. Mecha Ape",
        genres: [
          Genre(id: 28, name: "Action"),
          Genre(id: 878, name: "Science Fiction"),
        ],
      ),
      PopularMovieModel(
        backdropPath: '/xOMo8BRK7PfcJv9JCnx7s5hj0PX.jpg',
        id: 693134,
        originalTitle: "Dune: Part Two",
        popularity: 1390.639,
        posterPath: "/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg",
        title: "Dune: Part Two",
        genres: [
          Genre(id: 878, name: "Science Fiction"),
          Genre(id: 12, name: "Adventure"),
        ],
      ),
      PopularMovieModel(
        backdropPath: '/4woSOUD0equAYzvwhWBHIJDCM88.jpg',
        id: 1096197,
        originalTitle: "No Way Up",
        popularity: 1245.817,
        posterPath: "/hu40Uxp9WtpL34jv3zyWLb5zEVY.jpg",
        title: "No Way Up",
        genres: [
          Genre(id: 28, name: "Action"),
          Genre(id: 27, name: "Horror"),
          Genre(id: 53, name: "Thriller"),
        ],
      ),
      PopularMovieModel(
        backdropPath: '/kYgQzzjNis5jJalYtIHgrom0gOx.jpg',
        id: 1011985,
        originalTitle: "Kung Fu Panda 4",
        popularity: 1230.013,
        posterPath: "/kDp1vUBnMpe8ak4rjgl3cLELqjU.jpg",
        title: "Kung Fu Panda 4",
        genres: [
          Genre(id: 16, name: "Animation"),
          Genre(id: 28, name: "Action"),
          Genre(id: 10751, name: "Family"),
          Genre(id: 35, name: "Comedy"),
          Genre(id: 14, name: "Fantasy"),
        ],
      ),
      PopularMovieModel(
        backdropPath: '/tpiqEVTLRz2Mq7eLq5DT8jSrp71.jpg',
        id: 934632,
        originalTitle: "Rebel Moon - Part Two: The Scargiver",
        popularity: 1187.439,
        posterPath: "/cxevDYdeFkiixRShbObdwAHBZry.jpg",
        title: "Rebel Moon - Part Two: The Scargiver",
        genres: [
          Genre(id: 878, name: "Science Fiction"),
          Genre(id: 28, name: "Action"),
          Genre(id: 18, name: "Drama"),
        ],
      ),
      PopularMovieModel(
        backdropPath: '/5Eip60UDiPLASyKjmHPMruggTc4.jpg',
        id: 1041613,
        originalTitle: "Immaculate",
        popularity: 892.57,
        posterPath: "/fdZpvODTX5wwkD0ikZNaClE4AoW.jpg",
        title: "Immaculate",
        genres: [
          Genre(id: 27, name: "Horror"),
          Genre(id: 9648, name: "Mystery"),
          Genre(id: 53, name: "Thriller"),
        ],
      ),
      PopularMovieModel(
        backdropPath: '/6a3aiSYNqABoV1Fq8n10LMOBxhH.jpg',
        id: 821937,
        originalTitle: "578: Phát Đạn Của Kẻ Điên",
        popularity: 843.881,
        posterPath: "/8Nw5v7wPfa2FwbKyx61K2nIBcKa.jpg",
        title: "578: Magnum",
        genres: [
          Genre(id: 28, name: "Action"),
          Genre(id: 53, name: "Thriller"),
        ],
      ),
      PopularMovieModel(
        backdropPath: '/qGJASuD3fs9ZBxuEZoxCLVidVq8.jpg',
        id: 845111,
        originalTitle: "Les trois mousquetaires : Milady",
        popularity: 796.029,
        posterPath: "/rtosxP5sXuoRFPH4sVbMccLIPiV.jpg",
        title: "The Three Musketeers: Milady",
        genres: [
          Genre(id: 12, name: "Adventure"),
          Genre(id: 28, name: "Action"),
          Genre(id: 18, name: "Drama"),
        ],
      ),
      PopularMovieModel(
        backdropPath: '/v5XyXZe8FADw8iHupB4L7QOAwH9.jpg',
        id: 748783,
        originalTitle: "The Garfield Movie",
        popularity: 757.742,
        posterPath: "/zK2sFxZcelHJRPVr242rxy5VK4T.jpg",
        title: "The Garfield Movie",
        genres: [
          Genre(id: 16, name: "Animation"),
          Genre(id: 35, name: "Comedy"),
          Genre(id: 10751, name: "Family"),
        ],
      ),
    ];
  }

  static List<PopularMovieModel> getPopularMoviesSortedByPopularity() {
    List<PopularMovieModel> movies = mockPopularMovie();
    movies.sort((a, b) => b.popularity.compareTo(a.popularity));

    return movies;
  }
}
