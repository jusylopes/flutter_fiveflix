part of 'search_bloc.dart';

@immutable
abstract class SearchState extends Equatable {}

class SearchInitial extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchLoading extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchSuccess extends SearchState {
  SearchSuccess({required this.searchResult});
  final List<MediaModel> searchResult;

  @override
  List<Object?> get props => [searchResult];
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);

  @override
  List<Object?> get props => [message];
}
