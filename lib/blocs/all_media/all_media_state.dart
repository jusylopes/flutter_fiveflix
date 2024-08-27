part of 'all_media_bloc.dart';

abstract class AllMediaState extends Equatable {}

class AllMediaInitialState extends AllMediaState {
  @override
  List<Object> get props => [];
}

class ALLMediaLoadingState extends AllMediaState {
  @override
  List<Object> get props => [];
}

class AllMediaSuccessState extends AllMediaState {
  AllMediaSuccessState({required this.allMedias});

  final List<MediaModel> allMedias;

  @override
  List<Object> get props => [allMedias];
}

class AllMediaErrorState extends AllMediaState {
  final String errorMessage;

  AllMediaErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
