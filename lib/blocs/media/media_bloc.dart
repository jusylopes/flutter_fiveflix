import 'package:flutter_fiveflix/repositories/media_repository.dart';
import 'package:flutter_fiveflix/blocs/bloc_exports.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

part 'media_event.dart';
part 'media_state.dart';

class MediaBloc extends Bloc<MediaEvent, MediaState> {
  final MediaRepository _repository;

  MediaBloc({required MediaRepository repository})
      : _repository = repository,
        super(MediaInitialState()) {
    on<PopularMovieFetchEvent>(_onPopularMovieFetchEvent);
    on<PopularSerieFetchEvent>(_onPopularSerieFetchEvent);
    on<TopRatedFetchEvent>(_onTopRatedFetchEvent);
    on<NewsFetchEvent>(_onNewsFetchEvent);
    on<MediaDetailFetchEvent>(_onMediaDetailFetchEvent);
  }

  void _onPopularMovieFetchEvent(
      PopularMovieFetchEvent event, Emitter<MediaState> emit) async {
    emit(MediaLoadingState());

    try {
      final List<MediaModel> popularMovies = await _repository.getListMedia(
          endpoint: FiveflixStrings.endpointPopularMovies,
          fromJson: (json) => MediaModel.fromJson(json),
          keyJson: FiveflixStrings.keyJsonResults);

      final List<MediaModel> responseUpcoming = await _repository.getListMedia(
          endpoint: FiveflixStrings.endpointUpcoming,
          fromJson: (json) => MediaModel.fromJson(json),
          keyJson: FiveflixStrings.keyJsonResults);
      emit(
        PopularMovieSuccessState(
          popularMedias: popularMovies,
          upCommingMedias: responseUpcoming,
        ),
      );
    } catch (e) {
      emit(
        MediaErrorState(e.toString()),
      );
    }
  }

  void _onPopularSerieFetchEvent(
      PopularSerieFetchEvent event, Emitter<MediaState> emit) async {
    emit(MediaLoadingState());

    try {
      final List<MediaModel> popularSeries = await _repository.getListMedia(
          endpoint: FiveflixStrings.endpointPopularSeries,
          fromJson: (json) => MediaModel.fromJson(json),
          keyJson: FiveflixStrings.keyJsonResults);

      final List<MediaModel> topRatedTv = await _repository.getListMedia(
          endpoint: FiveflixStrings.endpointTopRatedTV,
          fromJson: (json) => MediaModel.fromJson(json),
          keyJson: FiveflixStrings.keyJsonResults);

      emit(
        PopularSerieSuccessState(
            popularMedias: popularSeries, topRatedTv: topRatedTv),
      );
    } catch (e) {
      emit(
        MediaErrorState(e.toString()),
      );
    }
  }

  void _onTopRatedFetchEvent(
      TopRatedFetchEvent event, Emitter<MediaState> emit) async {
    emit(MediaLoadingState());

    try {
      final List<MediaModel> responseMovies = await _repository.getListMedia(
          endpoint: FiveflixStrings.endpointTopRated,
          fromJson: (json) => MediaModel.fromJson(json),
          keyJson: FiveflixStrings.keyJsonResults);

      emit(
        TopRatedSucessState(
          topRatedMovies: responseMovies,
        ),
      );
    } catch (e) {
      MediaErrorState(e.toString());
    }
  }

  void _onNewsFetchEvent(NewsFetchEvent event, Emitter<MediaState> emit) async {
    emit(MediaLoadingState());

    try {
      final List<MediaModel> responseMovies = await _repository.getListMedia(
          endpoint: FiveflixStrings.endpointNews,
          fromJson: (json) => MediaModel.fromJson(json),
          keyJson: FiveflixStrings.keyJsonResults);

      emit(
        NewsSuccessState(
          newsMovies: responseMovies,
        ),
      );
    } catch (e) {
      emit(MediaErrorState(e.toString()));
    }
  }

  void _onMediaDetailFetchEvent(
      MediaDetailFetchEvent event, Emitter<MediaState> emit) async {
    emit(MediaLoadingState());

    try {
      final List<TrailerModel> trailers = await _repository.getListMedia(
          endpoint:
              '${FiveflixStrings.endpointMedia}${event.mediaType}/${event.id}${FiveflixStrings.endpointTrailer}',
          fromJson: (json) => TrailerModel.fromJson(json),
          keyJson: FiveflixStrings.keyJsonResults);

      final List<CastModel> casts = await _repository.getListMedia(
          endpoint:
              '${FiveflixStrings.endpointMedia}${event.mediaType}/${event.id}${FiveflixStrings.endpointCast}',
          fromJson: (json) => CastModel.fromJson(json),
          keyJson: FiveflixStrings.keyJsonCast);

      emit(
        MediaDetailSucessState(
          casts: casts,
          trailers: trailers,
        ),
      );
    } catch (e) {
      emit(
        MediaErrorState(e.toString()),
      );
    }
  }
}
