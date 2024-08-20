part of 'all_media_bloc.dart';

abstract class AllMediaEvent extends Equatable {
  const AllMediaEvent();
}

class AllMediaFetchEvent extends AllMediaEvent {
  final AllMediaType mediaType;
  final String idGenre;

  AllMediaFetchEvent({required this.mediaType, this.idGenre = ''});

  @override
  List<Object> get props => [mediaType, idGenre];
}

class ResetAllMediaEvent extends AllMediaEvent {
  @override
  List<Object?> get props => [];
}
