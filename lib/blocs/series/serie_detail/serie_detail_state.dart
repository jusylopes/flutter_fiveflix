import 'package:equatable/equatable.dart';
import 'package:flutter_fiveflix/models/serie_detail.dart';


abstract class SerieDetailState extends Equatable {}

class InitialState extends SerieDetailState {
  @override
  List<Object> get props => [];
}

class LoadingState extends SerieDetailState {
  @override
  List<Object> get props => [];
}

class SuccessState extends SerieDetailState {
  SuccessState({required this.serie});
  final SerieDetailModel serie;

  @override
  List<Object> get props => [serie];
}

class ErrorState extends SerieDetailState {
  @override
  List<Object> get props => [];
}
