part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class Search extends SearchEvent {
  const Search({required this.query});

  final String query;

  @override
  List<Object> get props => [query];
}
