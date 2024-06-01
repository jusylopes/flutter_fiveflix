part of 'media_bloc.dart';

abstract class MediaState extends Equatable {}

class MediaInitialState extends MediaState {
  @override
  List<Object> get props => [];
}

class MediaLoadingState extends MediaState {
  @override
  List<Object> get props => [];
}

class PopularSuccessState extends MediaState {
  PopularSuccessState(
      {required this.popularMovies, required this.popularSeries});

  final List<MediaModel> popularSeries;
  final List<MediaModel> popularMovies;

  @override
  List<Object> get props => [popularMovies, popularSeries];
}

class NewsSuccessState extends MediaState {
  NewsSuccessState({required this.newsMovies});

  final List<MediaModel> newsMovies;

  @override
  List<Object> get props => [newsMovies];
}

class TopRatedSucessState extends MediaState {
  TopRatedSucessState({required this.topRatedMovies});

  final List<MediaModel> topRatedMovies;

  @override
  List<Object> get props => [topRatedMovies];
}

class CastSucessState extends MediaState {
  CastSucessState({required this.casts});

  final List<CastModel> casts;

  @override
  List<Object> get props => [casts];
}

class TrailerSucessState extends MediaState {
  TrailerSucessState({required this.trailers});

  final List<TrailerModel> trailers;

  @override
  List<Object> get props => [trailers];
}

class MediaDetailSucessState extends MediaState {
  MediaDetailSucessState({
    required this.trailers,
    required this.casts,
  });

  final List<CastModel> casts;
  final List<TrailerModel> trailers;

  @override
  List<Object> get props => [casts, trailers];
}

class MediaErrorState extends MediaState {
  final String errorMessage;

  MediaErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
