import 'package:equatable/equatable.dart';

abstract class SerieDetailEvent extends Equatable {
  const SerieDetailEvent();
}

class SerieDetailFetchEvent extends SerieDetailEvent {
  final int id;
  const SerieDetailFetchEvent(this.id);

  @override
  List<Object> get props => [id];
}
