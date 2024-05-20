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
  MovieDetailSuccessState({
    required this.castMovie,
    required this.movie,
  });
  final MovieDetailModel movie;
  final List<CastModel> castMovie;

  @override
  List<Object> get props => [movie, castMovie];
}

class MovieCastSuccessState extends MediaDetailState {
  MovieCastSuccessState({required this.movieCast});
  final List<CastModel> movieCast;

  @override
  List<Object> get props => [movieCast];
}

class SerieDetailSuccessState extends MediaDetailState {
  SerieDetailSuccessState({
    required this.castSerie,
    required this.serie,
  });
  final SerieDetailModel serie;
  final List<CastModel> castSerie;

  @override
  List<Object> get props => [serie, castSerie];
}

class ErrorState extends MediaDetailState {
  @override
  List<Object> get props => [];
}
