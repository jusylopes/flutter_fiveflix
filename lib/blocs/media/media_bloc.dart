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
    on<PopularMediaFetchEvent>(_onPopularMovieFetchEvent);
    on<TopRatedFetchEvent>(_onTopRatedFetchEvent);
    on<NewsFetchEvent>(_onNewsFetchEvent);
  }

  void _onPopularMovieFetchEvent(
      PopularMediaFetchEvent event, Emitter<MediaState> emit) async {
    emit(MediaLoadingState());

    try {
      final List<MovieModel> responseMovies = await _repository.getListMedia(
          endpoint: FiveflixStrings.endpointPopularMovies,
          fromJson: (json) => MovieModel.fromJson(json),
          keyJson: FiveflixStrings.keyJsonResults);

      final List<SerieModel> responseSeries = await _repository.getListMedia(
          endpoint: FiveflixStrings.endpointPopularSeries,
          fromJson: (json) => SerieModel.fromJson(json),
          keyJson: FiveflixStrings.keyJsonResults);

      emit(
        PopularSuccessState(
          popularMovies: responseMovies,
          popularSeries: responseSeries,
        ),
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
      final List<MovieModel> responseMovies = await _repository.getListMedia(
          endpoint: FiveflixStrings.endpointTopRated,
          fromJson: (json) => MovieModel.fromJson(json),
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
      final List<MovieModel> responseMovies = await _repository.getListMedia(
          endpoint: FiveflixStrings.endpointNews,
          fromJson: (json) => MovieModel.fromJson(json),
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
}
