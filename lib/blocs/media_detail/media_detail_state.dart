part of 'media_detail_bloc.dart';

abstract class MediaDetailState extends Equatable {}

class MediaDetailInitialState extends MediaDetailState {
  @override
  List<Object> get props => [];
}

class MediaDetailLoadingState extends MediaDetailState {
  @override
  List<Object> get props => [];
}

class MovieDetailSuccessState extends MediaDetailState {
  MovieDetailSuccessState({
    required this.trailer,
    required this.castMovie,
    required this.movie,
  });
  final MovieDetailModel movie;
  final List<CastModel> castMovie;
  final List<TrailerModel> trailer;

  @override
  List<Object> get props => [movie, castMovie, trailer];
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

class MediaDetailErrorState extends MediaDetailState {
  MediaDetailErrorState(this.errorMessage);
  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
