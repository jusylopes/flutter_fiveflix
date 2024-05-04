import 'package:equatable/equatable.dart';
import 'package:flutter_fiveflix/models/movie_detail_model.dart';

abstract class MovieDetailState extends Equatable {}

class InitialState extends MovieDetailState {
  @override
  List<Object> get props => [];
}

class LoadingState extends MovieDetailState {
  @override
  List<Object> get props => [];
}

class SuccessState extends MovieDetailState {
  SuccessState({required this.movie});
  final MovieDetailModel movie;

  @override
  List<Object> get props => [movie];
}

class ErrorState extends MovieDetailState {
  @override
  List<Object> get props => [];
}
