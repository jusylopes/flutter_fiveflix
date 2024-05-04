import 'package:flutter_fiveflix/models/popular_movie_model.dart';

abstract class MockupPopularMovie {
  static List<PopularMovieModel> mockPopularMovie() {
    return [
      PopularMovieModel(
        id: 12153,
        originalTitle: "White Chicks",
        popularity: 143.356,
        posterPath: "/aHTUpo45qy9QYIOnVITGGqLoVcA.jpg",
        title: "White Chicks",
      ),
      PopularMovieModel(
        id: 70817,
        originalTitle: "Super Xuxa Contra Baixo Astral",
        popularity: 4.483,
        posterPath: "/ql6MZBvObtdPUSp8IYwk5j1vygu.jpg",
        title: "Super Xuxa Against The Down Mood",
      ),
      PopularMovieModel(
        id: 9470,
        originalTitle: "功夫",
        popularity: 51.891,
        posterPath: "/exbyTbrvRUDKN2mcNEuVor4VFQW.jpg",
        title: "Kung Fu Hustle",
      ),
      PopularMovieModel(
        id: 254384,
        originalTitle: "O Noviço Rebelde",
        popularity: 2.878,
        posterPath: "/d52YpTkEcvOV3bLbvu05SKPoBUz.jpg",
        title: "O Noviço Rebelde",
      ),
      PopularMovieModel(
        id: 36122,
        originalTitle: "Acquária",
        popularity: 7.021,
        posterPath: "/15VmIvC923t6l2WJdneHdGG20oH.jpg",
        title: "Acquária",
      ),
      PopularMovieModel(
        id: 8467,
        originalTitle: "Dumb and Dumber",
        popularity: 158.304,
        posterPath: "/4LdpBXiCyGKkR8FGHgjKlphrfUc.jpg",
        title: "Dumb and Dumber",
      ),
      PopularMovieModel(
        id: 5689,
        originalTitle: "The Blue Lagoon",
        popularity: 48.016,
        posterPath: "/vSYaATEBqsy0Ad4CQxs3D5IXQUm.jpg",
        title: "The Blue Lagoon",
      ),
      PopularMovieModel(
        id: 128449,
        originalTitle: "Simão, o Fantasma Trapalhão",
        popularity: 6.237,
        posterPath: "/6unRVrRwxpTrbkxDV3u9UAv8hCy.jpg",
        title: "Simão, o Fantasma Trapalhão",
      ),
      PopularMovieModel(
        id: 3049,
        originalTitle: "Ace Ventura: Pet Detective",
        popularity: 46.741,
        posterPath: "/yaHnZqJvsSddOKYxf4zCj2Ww2hA.jpg",
        title: "Ace Ventura: Pet Detective",
      ),
      PopularMovieModel(
        id: 40264,
        originalTitle: "Vampires Suck",
        popularity: 62.823,
        posterPath: "/ksPKfoXovAiFnBktkCBefsRQ8a1.jpg",
        title: "Vampires Suck",
      ),
    ];
  }

  static List<PopularMovieModel> getPopularMoviesSortedByPopularity() {
    List<PopularMovieModel> movies = mockPopularMovie();
    movies.sort((a, b) => b.popularity.compareTo(a.popularity));

    return movies;
  }
}
