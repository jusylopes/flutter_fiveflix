import 'package:equatable/equatable.dart';
import 'package:flutter_fiveflix/models/popular_movie_model.dart';
import 'package:flutter_fiveflix/models/popular_serie_model.dart';

abstract class PopularMediaState extends Equatable {}

class InitialState extends PopularMediaState {
  @override
  List<Object> get props => [];
}

class LoadingState extends PopularMediaState {
  @override
  List<Object> get props => [];
}

class PopularMovieSuccessState extends PopularMediaState {
  PopularMovieSuccessState({required this.popularMovies});
  final List<PopularMovieModel> popularMovies;

  @override
  List<Object> get props => [popularMovies];
}

class PopularSerieSuccessState extends PopularMediaState {
  PopularSerieSuccessState({required this.popularSeries});
  final List<PopularSerieModel> popularSeries;

  @override
  List<Object> get props => [popularSeries];
}

class ErrorState extends PopularMediaState {
  @override
  List<Object> get props => [];
}
