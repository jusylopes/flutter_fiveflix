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

