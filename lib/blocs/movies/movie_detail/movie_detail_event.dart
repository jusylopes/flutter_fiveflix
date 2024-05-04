import 'package:equatable/equatable.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();
}

class MovieDetailFetchEvent extends MovieDetailEvent {
  final int id;
  const MovieDetailFetchEvent(this.id);

  @override
  List<Object> get props => [id];
}
