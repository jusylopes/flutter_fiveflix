import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fiveflix/blocs/media_detail_screen/media_detail_event.dart';
import 'package:flutter_fiveflix/blocs/media_detail_screen/media_detail_state.dart';
import 'package:flutter_fiveflix/models/movie_detail_model.dart';
import 'package:flutter_fiveflix/models/serie_detail_model.dart';

import 'package:flutter_fiveflix/repositories/media_repository.dart';

class MediaDetailBloc extends Bloc<MediaDetailEvent, MediaDetailState> {
  final MediaRepository _repository;

  MediaDetailBloc({required MediaRepository repository})
      : _repository = repository,
        super(InitialState()) {
    on<MovieDetailFetchEvent>(_onMovieDetailFetchEvent);
    on<SerieDetailFetchEvent>(_onSerieDetailFetchEvent);
  }

  void _onMovieDetailFetchEvent(
      MovieDetailFetchEvent event, Emitter<MediaDetailState> emit) async {
    emit(LoadingState());

    try {
      final MovieDetailModel movie =
          await _repository.getMovieDetail(id: event.id);

      emit(
        MovieDetailSuccessState(
          movie: movie,
        ),
      );
    } catch (e) {
      emit(ErrorState());
    }
  }

  void _onSerieDetailFetchEvent(
      SerieDetailFetchEvent event, Emitter<MediaDetailState> emit) async {
    emit(LoadingState());

    try {
      final SerieDetailModel serie =
          await _repository.getSerieDetail(id: event.id);

      emit(
        SerieDetailSuccessState(
          serie: serie,
        ),
      );
    } catch (e) {
      emit(ErrorState());
    }
  }
}
