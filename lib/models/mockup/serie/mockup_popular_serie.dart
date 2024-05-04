import 'package:flutter_fiveflix/models/popular_serie_model.dart';

abstract class MockupPopularSerie {
  static List<PopularSerieModel> mockPopularSerie() {
    return [
      PopularSerieModel(
          id: 1620,
          originalName: "CSI: Miami",
          popularity: 2515.982,
          posterPath: "/pNW64pjaHvf6purNaFhq4SHYRfl.jpg",
          name: "CSI: Miami"),
          PopularSerieModel(
          id: 1431,
          originalName: "CSI: Crime Scene Investigation",
          popularity: 2277.626,
          posterPath: "/i5hmoRjHNWady4AtAGICTUXknKH.jpg",
          name: "CSI: Crime Scene Investigation"),
          PopularSerieModel(
          id: 2734,
          originalName: "Law & Order: Special Victims Unit",
          popularity: 4190.138,
          posterPath: "/onmSVwYsPMYtO8OjLdjS8FfRNKb.jpg",
          name: "Law & Order: Special Victims Unit"),
          PopularSerieModel(
          id: 1416,
          originalName: "Grey's Anatomy",
          popularity: 3212.363,
          posterPath: "/jcEl8SISNfGdlQFwLzeEtsjDvpw.jpg",
          name: "Grey's Anatomy"),
          PopularSerieModel(
          id: 39351,
          originalName: "Grimm",
          popularity: 2883.867,
          posterPath: "/iOptnt1QHi6bIHmOq6adnZTV0bU.jpg",
          name: "Grimm"),
          PopularSerieModel(
          id: 1622,
          originalName: "Supernatural",
          popularity: 2833.636,
          posterPath: "/KoYWXbnYuS3b0GyQPkbuexlVK9.jpg",
          name: "Supernatural"),
           PopularSerieModel(
          id: 1622,
          originalName: "No Rancho Fundo",
          popularity: 2569.773,
          posterPath: "/eONkvEahSQJan1HTzWJKjvaMe29.jpg",
          name: "No Rancho Fundo"),
           PopularSerieModel(
          id: 22980,
          originalName: "Watch What Happens Live with Andy Cohen",
          popularity: 2308.722,
          posterPath: "/onSD9UXfJwrMXWhq7UY7hGF2S1h.jpg",
          name: "Watch What Happens Live with Andy Cohen"),
           PopularSerieModel(
          id: 1667,
          originalName: "Saturday Night Live",
          popularity: 2152.942,
          posterPath: "/iecMwr0L6kt64qeyyeYUxBjuQ4G.jpg",
          name: "Saturday Night Live"),
          PopularSerieModel(
          id: 240909,
          originalName: "La Casa de los Famosos Colombia",
          popularity: 2348.831,
          posterPath: "/lCn94cscNlFToXIbIWRSGBqb20Q.jpg",
          name: "La Casa de los Famosos Colombia"),
          
    ];
  }

  static List<PopularSerieModel> getPopularMoviesSortedByPopularity() {
    List<PopularSerieModel> movies = mockPopularSerie();
    movies.sort((a, b) => b.popularity.compareTo(a.popularity));

    return movies;
  }
}
