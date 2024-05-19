import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fiveflix/models/search_model.dart';
import 'package:flutter_fiveflix/repositories/media_repository.dart';
import 'package:flutter_fiveflix/utils/api_base_options.dart';
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
      String refactoredQuery = _removeSpaceWithAmpersand(event.query);

      List<SearchModel> mediaList = await _repository.getListMedia(
        endpoint: endpointSearch + refactoredQuery,
        fromJson: (json) => SearchModel.fromJson(json),
      );

      emit(SearchSuccess(mediaList: mediaList));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  String _removeSpaceWithAmpersand(String query) {
    query = query.trim();
    return query.replaceAll("\\s+", "&");
  }
}
