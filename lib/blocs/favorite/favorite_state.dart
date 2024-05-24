part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {}

class InitialState extends FavoriteState {
  @override
  List<Object> get props => [];
}

class LoadingState extends FavoriteState {
  @override
  List<Object> get props => [];
}

class FavoriteMovieSuccessState extends FavoriteState {
  FavoriteMovieSuccessState({
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

class FavoriteSerieSuccessState extends FavoriteState {
  FavoriteSerieSuccessState({
    required this.castSerie,
    required this.serie,
  });
  final SerieDetailModel serie;
  final List<CastModel> castSerie;

  @override
  List<Object> get props => [serie, castSerie];
}

class ErrorState extends FavoriteState {
  @override
  List<Object> get props => [];
}
