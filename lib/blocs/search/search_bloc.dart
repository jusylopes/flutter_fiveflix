import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fiveflix/models/search_model.dart';
import 'package:flutter_fiveflix/repositories/media_repository.dart';
import 'package:flutter_fiveflix/utils/strings.dart';
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

      List<SearchModel> mediaList = await _repository.getListMedia(
          endpoint: AppStrings.endpointSearch + refactoredQuery,
          fromJson: (json) => SearchModel.fromJson(json),
          keyJson: AppStrings.keyJsonResults);

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
