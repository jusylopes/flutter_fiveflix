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

  final List<PopularSerieModel> popularSeries;
  final List<MediaMovieModel> popularMovies;

  @override
  List<Object> get props => [popularMovies, popularSeries];
}

class NewsSuccessState extends MediaState {
  NewsSuccessState({required this.newsMovies});

  final List<MediaMovieModel> newsMovies;

  @override
  List<Object> get props => [newsMovies];
}

class TopRatedSucessState extends MediaState {
  TopRatedSucessState({required this.topRatedMovies});

  final List<MediaMovieModel> topRatedMovies;

  @override
  List<Object> get props => [topRatedMovies];
}



class ErrorState extends MediaState {
  @override
  List<Object> get props => [];
}
