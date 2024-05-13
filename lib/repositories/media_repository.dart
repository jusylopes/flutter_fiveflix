import 'package:flutter_fiveflix/models/mockup/movie/mockup_movie_detail.dart';
import 'package:flutter_fiveflix/models/mockup/movie/mockup_popular.dart';
import 'package:flutter_fiveflix/models/mockup/serie/mockup_popular_serie.dart';
import 'package:flutter_fiveflix/models/mockup/serie/mockup_serie_detail.dart';
import 'package:flutter_fiveflix/models/movie_detail_model.dart';
import 'package:flutter_fiveflix/models/popular_movie_model.dart';
import 'package:flutter_fiveflix/models/popular_serie_model.dart';
import 'package:flutter_fiveflix/models/serie_detail_model.dart';

class MediaRepository {
  Future<List<PopularMovieModel>> getPopularMovies() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return MockupPopularMovie.getPopularMoviesSortedByPopularity();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PopularSerieModel>> getPopularSeries() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return MockupPopularSerie.mockPopularSerie();
    } catch (e) {
      rethrow;
    }
  }

  Future<MovieDetailModel> getMovieDetail({required int id}) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return MockupMovieDetail.getMovieById(id);
    } catch (e) {
      rethrow;
    }
  }

  Future<SerieDetailModel> getSerieDetail({required int id}) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return MockupSerieDetail.getSerieById(id);
    } catch (e) {
      rethrow;
    }
  }
}
