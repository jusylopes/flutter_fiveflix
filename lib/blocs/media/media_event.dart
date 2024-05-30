part of 'media_bloc.dart';

abstract class MediaEvent extends Equatable {
  const MediaEvent();
}

class PopularMediaFetchEvent extends MediaEvent {
  @override
  List<Object> get props => [];
}

class TopRatedFetchEvent extends MediaEvent {
  @override
  List<Object> get props => [];
}

class NewsFetchEvent extends MediaEvent {
  @override
  List<Object> get props => [];
}

class MediaDetailFetchEvent extends MediaEvent {
  const MediaDetailFetchEvent({
    required this.id,
    required this.mediaType,
  });

  final int id;
  final String mediaType;
  @override
  List<Object> get props => [id, mediaType];
}
