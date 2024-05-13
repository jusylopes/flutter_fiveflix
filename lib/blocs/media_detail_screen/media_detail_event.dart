part of 'media_detail_bloc.dart';

abstract class MediaDetailEvent extends Equatable {
  const MediaDetailEvent();
}

class MovieDetailFetchEvent extends MediaDetailEvent {
  const MovieDetailFetchEvent({required this.id});

  final int id;

  @override
  List<Object> get props => [id];
}

class SerieDetailFetchEvent extends MediaDetailEvent {
  const SerieDetailFetchEvent({required this.id});

  final int id;

  @override
  List<Object> get props => [id];
}
