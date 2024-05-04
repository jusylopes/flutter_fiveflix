import 'package:equatable/equatable.dart';

abstract class PopularMovieEvent extends Equatable {
  const PopularMovieEvent();
}

class PopularMovieFetchEvent extends PopularMovieEvent {
  @override
  List<Object> get props => [];
}
