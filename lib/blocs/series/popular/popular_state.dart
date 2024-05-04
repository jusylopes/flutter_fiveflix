import 'package:equatable/equatable.dart';
import 'package:flutter_fiveflix/models/popular_serie_model.dart';

abstract class PopularSerieState extends Equatable {}

class InitialState extends PopularSerieState {
  @override
  List<Object> get props => [];
}

class LoadingState extends PopularSerieState {
  @override
  List<Object> get props => [];
}

class SuccessState extends PopularSerieState {
  SuccessState({required this.popularSeries});
  final List<PopularSerieModel> popularSeries;

  @override
  List<Object> get props => [popularSeries];
}

class ErrorState extends PopularSerieState {
  @override
  List<Object> get props => [];
}
