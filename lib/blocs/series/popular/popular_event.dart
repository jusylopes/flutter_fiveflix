import 'package:equatable/equatable.dart';

abstract class PopularSerieEvent extends Equatable {
  const PopularSerieEvent();
}

class PopularSerieFetchEvent extends PopularSerieEvent {
  @override
  List<Object> get props => [];
}
