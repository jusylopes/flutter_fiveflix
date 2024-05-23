part of 'media_bloc.dart';

abstract class MediaState extends Equatable {}

class InitialState extends MediaState {
  @override
  List<Object> get props => [];
}

class LoadingState extends MediaState {
  @override
  List<Object> get props => [];
}

class PopularSuccessState extends MediaState {
  PopularSuccessState(
      {required this.popularMovies, required this.popularSeries});

  final List<SerieModel> popularSeries;
  final List<MovieModel> popularMovies;

  @override
  List<Object> get props => [popularMovies, popularSeries];
}

class NewsSuccessState extends MediaState {
  NewsSuccessState({required this.newsMovies});

  final List<MovieModel> newsMovies;

  @override
  List<Object> get props => [newsMovies];
}

class TopRatedSucessState extends MediaState {
  TopRatedSucessState({required this.topRatedMovies});

  final List<MovieModel> topRatedMovies;

  @override
  List<Object> get props => [topRatedMovies];
}

class ErrorState extends MediaState {
  final String errorMessage;

  ErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
