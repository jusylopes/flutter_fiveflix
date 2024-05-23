import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fiveflix/models/cast_model.dart';
import 'package:flutter_fiveflix/models/movie_detail_model.dart';
import 'package:flutter_fiveflix/models/serie_detail_model.dart';
import 'package:flutter_fiveflix/models/trailer_model.dart';
import 'package:flutter_fiveflix/repositories/media_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fiveflix/utils/strings.dart';

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
        endpoint: AppStrings.endpointMovieDetail + event.id.toString(),
        fromJson: (json) => MovieDetailModel.fromJson(json),
      );

      final List<CastModel> cast = await _repository.getListMedia(
          endpoint: AppStrings.endpointMovieDetail +
              event.id.toString() +
              AppStrings.endpointCast,
          fromJson: (json) => CastModel.fromJson(json),
          keyJson: AppStrings.keyJsonCast);

      final List<TrailerModel> trailer = await _repository.getListMedia(
          endpoint: AppStrings.endpointMovieDetail +
              event.id.toString() +
              AppStrings.endpointTrailer,
          fromJson: (json) => TrailerModel.fromJson(json),
          keyJson: AppStrings.keyJsonResults);

      emit(
        MovieDetailSuccessState(
          movie: movie,
          castMovie: cast,
          trailer: trailer,
        ),
      );
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  void _onSerieDetailFetchEvent(
      SerieDetailFetchEvent event, Emitter<MediaDetailState> emit) async {
    emit(LoadingState());

    try {
      final SerieDetailModel serie = await _repository.getMediaDetail(
        endpoint: AppStrings.endpointSerieDetail + event.id.toString(),
        fromJson: (json) => SerieDetailModel.fromJson(json),
      );

      final List<CastModel> cast = await _repository.getListMedia(
          endpoint: AppStrings.endpointSerieDetail +
              event.id.toString() +
              AppStrings.endpointCast,
          fromJson: (json) => CastModel.fromJson(json),
          keyJson: AppStrings.keyJsonCast);

      emit(
        SerieDetailSuccessState(
          serie: serie,
          castSerie: cast,
        ),
      );
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
