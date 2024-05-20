part of 'news_bloc.dart';

abstract class NewsState extends Equatable {}

class InitialState extends NewsState {
  @override
  List<Object> get props => [];
}

class LoadingState extends NewsState {
  @override
  List<Object> get props => [];
}

class NewsSuccessState extends NewsState {
  NewsSuccessState({required this.newsMovies});

  final List<MediaMovieModel> newsMovies;

  @override
  List<Object> get props => [newsMovies];
}

class ErrorState extends NewsState {
  @override
  List<Object> get props => [];
}
