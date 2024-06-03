import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/blocs/bloc_exports.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/repositories/media_repository.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final MediaRepository _repository;

  SearchBloc({required MediaRepository repository})
      : _repository = repository,
        super(SearchInitial()) {
    on<Search>(_onSearch);
  }

  void _onSearch(Search event, Emitter<SearchState> emit) async {
    emit(SearchLoading());

    try {
      String refactoredQuery = _refactoredQuery(event.query);

      List<MediaModel> mediaList = await _repository.getListMedia(
          endpoint: FiveflixStrings.endpointSearch + refactoredQuery,
          fromJson: (json) => MediaModel.fromJson(json),
          keyJson: FiveflixStrings.keyJsonResults);

      emit(SearchSuccess(searchResult: mediaList));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  String _refactoredQuery(String query) {
    query = query.trim();
    return query.replaceAll("\\s+", "&");
  }
}
