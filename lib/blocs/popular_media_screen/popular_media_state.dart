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

class SuccessState extends PopularMediaState { 

  SuccessState({required this.popularMovies, required this.popularSeries});

  final List<PopularSerieModel> popularSeries;
  final List<PopularMovieModel> popularMovies;

  @override
  List<Object> get props => [popularMovies, popularSeries];
}

class ErrorState extends PopularMediaState {
  @override
  List<Object> get props => [];
}
