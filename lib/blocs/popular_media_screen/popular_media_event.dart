import 'package:equatable/equatable.dart';

abstract class PopularMediaEvent extends Equatable {
  const PopularMediaEvent();
}

class PopularMovieFetchEvent extends PopularMediaEvent {
  @override
  List<Object> get props => [];
}

class PopularSerieFetchEvent extends PopularMediaEvent {
  @override
  List<Object> get props => [];
}
