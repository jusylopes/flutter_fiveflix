import 'package:equatable/equatable.dart';
import 'package:flutter_fiveflix/models/popular_movie_model.dart';

abstract class PopularMovieState extends Equatable {}

class InitialState extends PopularMovieState {
  @override
  List<Object> get props => [];
}

class LoadingState extends PopularMovieState {
  @override
  List<Object> get props => [];
}

class SuccessState extends PopularMovieState {
  SuccessState({required this.popularMovies});
  final List<PopularMovieModel> popularMovies;

  @override
  List<Object> get props => [popularMovies];
}

class ErrorState extends PopularMovieState {
  @override
  List<Object> get props => [];
}
