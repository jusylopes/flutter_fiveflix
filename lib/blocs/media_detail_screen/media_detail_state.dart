part of 'media_detail_bloc.dart';

abstract class MediaDetailState extends Equatable {}

class InitialState extends MediaDetailState {
  @override
  List<Object> get props => [];
}

class LoadingState extends MediaDetailState {
  @override
  List<Object> get props => [];
}

class MovieDetailSuccessState extends MediaDetailState {
  MovieDetailSuccessState({required this.movie});
  final MovieDetailModel movie;

  @override
  List<Object> get props => [movie];
}

class SerieDetailSuccessState extends MediaDetailState {
  SerieDetailSuccessState({required this.serie});
  final SerieDetailModel serie;

  @override
  List<Object> get props => [serie];
}

class ErrorState extends MediaDetailState {
  @override
  List<Object> get props => [];
}
