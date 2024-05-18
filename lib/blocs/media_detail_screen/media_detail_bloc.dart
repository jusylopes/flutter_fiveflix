import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fiveflix/models/movie_detail_model.dart';
import 'package:flutter_fiveflix/models/serie_detail_model.dart';
import 'package:flutter_fiveflix/repositories/media_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fiveflix/utils/api_base_options.dart';

part 'media_detail_event.dart';
part 'media_detail_state.dart';

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
      final MovieDetailModel movie = await _repository.getMediaDetail(
        id: event.id,
        endpoint: endpointMovieDetail,
        fromJson: (json) => MovieDetailModel.fromJson(json),
      );

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
      await _repository.getMediaDetail(
        id: event.id, endpoint: endpointMovieDetail,
      fromJson: (json) => SerieDetailModel.fromJson(json),
      );
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
