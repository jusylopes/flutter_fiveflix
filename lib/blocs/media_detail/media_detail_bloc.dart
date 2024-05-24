import 'package:flutter_fiveflix/repositories/media_repository.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/blocs/bloc_exports.dart';

part 'media_detail_event.dart';
part 'media_detail_state.dart';

class MediaDetailBloc extends Bloc<MediaDetailEvent, MediaDetailState> {
  final MediaRepository _repository;

  MediaDetailBloc({required MediaRepository repository})
      : _repository = repository,
        super(MediaDetailInitialState()) {
    on<MovieDetailFetchEvent>(_onMovieDetailFetchEvent);
    on<SerieDetailFetchEvent>(_onSerieDetailFetchEvent);
  }

  void _onMovieDetailFetchEvent(
      MovieDetailFetchEvent event, Emitter<MediaDetailState> emit) async {
    emit(MediaDetailLoadingState());

    try {
      final MovieDetailModel movie = await _repository.getMediaDetail(
        endpoint: FiveflixStrings.endpointMovieDetail + event.id.toString(),
        fromJson: (json) => MovieDetailModel.fromJson(json),
      );

      final List<CastModel> cast = await _repository.getListMedia(
          endpoint: FiveflixStrings.endpointMovieDetail +
              event.id.toString() +
              FiveflixStrings.endpointCast,
          fromJson: (json) => CastModel.fromJson(json),
          keyJson: FiveflixStrings.keyJsonCast);

      final List<TrailerModel> trailer = await _repository.getListMedia(
          endpoint: FiveflixStrings.endpointMovieDetail +
              event.id.toString() +
              FiveflixStrings.endpointTrailer,
          fromJson: (json) => TrailerModel.fromJson(json),
          keyJson: FiveflixStrings.keyJsonResults);

      emit(
        MovieDetailSuccessState(
          movie: movie,
          castMovie: cast,
          trailer: trailer,
        ),
      );
    } catch (e) {
      emit(MediaDetailErrorState(e.toString()));
    }
  }

  void _onSerieDetailFetchEvent(
      SerieDetailFetchEvent event, Emitter<MediaDetailState> emit) async {
    emit(MediaDetailLoadingState());

    try {
      final SerieDetailModel serie = await _repository.getMediaDetail(
        endpoint: FiveflixStrings.endpointSerieDetail + event.id.toString(),
        fromJson: (json) => SerieDetailModel.fromJson(json),
      );

      final List<CastModel> cast = await _repository.getListMedia(
          endpoint: FiveflixStrings.endpointSerieDetail +
              event.id.toString() +
              FiveflixStrings.endpointCast,
          fromJson: (json) => CastModel.fromJson(json),
          keyJson: FiveflixStrings.keyJsonCast);

      emit(
        SerieDetailSuccessState(
          serie: serie,
          castSerie: cast,
        ),
      );
    } catch (e) {
      emit(MediaDetailErrorState(e.toString()));
    }
  }
}
