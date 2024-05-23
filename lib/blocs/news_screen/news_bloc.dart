import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fiveflix/models/movie_model.dart';
import 'package:flutter_fiveflix/repositories/media_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fiveflix/utils/strings.dart';
part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final MediaRepository _repository;

  NewsBloc({required MediaRepository repository})
      : _repository = repository,
        super(InitialState()) {
    on<NewsMediaFetchEvent>(_onNewsFetchEvent);
  }

  void _onNewsFetchEvent(
      NewsMediaFetchEvent event, Emitter<NewsState> emit) async {
    emit(LoadingState());

    try {
      final List<MovieModel> responseMovies = await _repository.getListMedia(
          endpoint: AppStrings.endpointNews,
          fromJson: (json) => MovieModel.fromJson(json),
          keyJson: AppStrings.keyJsonResults);

      emit(
        NewsSuccessState(
          newsMovies: responseMovies,
        ),
      );
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
