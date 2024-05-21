import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fiveflix/models/media_movie_model.dart';
import 'package:flutter_fiveflix/models/popular_serie_model.dart';
import 'package:flutter_fiveflix/repositories/media_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fiveflix/utils/strings.dart';
part 'media_event.dart';
part 'media_state.dart';

class MediaBloc extends Bloc<MediaEvent, MediaState> {
  final MediaRepository _repository;

  MediaBloc({required MediaRepository repository})
      : _repository = repository,
        super(InitialState()) {
    on<PopularMediaFetchEvent>(_onPopularMovieFetchEvent);
    on<TopRatedFetchEvent>(_onTopRatedFetchEvent);
  }

  void _onPopularMovieFetchEvent(
      PopularMediaFetchEvent event, Emitter<MediaState> emit) async {
    emit(LoadingState());

    try {
      final List<MediaMovieModel> responseMovies =
          await _repository.getListMedia(
              endpoint: AppStrings.endpointPopularMovies,
              fromJson: (json) => MediaMovieModel.fromJson(json),
              keyJson: AppStrings.keyJsonResults);

      final List<PopularSerieModel> responseSeries =
          await _repository.getListMedia(
              endpoint: AppStrings.endpointPopularSeries,
              fromJson: (json) => PopularSerieModel.fromJson(json),
              keyJson: AppStrings.keyJsonResults);

      emit(
        PopularSuccessState(
          popularMovies: responseMovies,
          popularSeries: responseSeries,
        ),
      );
    } catch (e) {
      emit(ErrorState());
    }
  }

  void _onTopRatedFetchEvent(
      TopRatedFetchEvent event, Emitter<MediaState> emit) async {
    emit(LoadingState());

    try {
      final List<MediaMovieModel> responseMovies =
          await _repository.getListMedia(
              endpoint: AppStrings.endpointTopRated,
              fromJson: (json) => MediaMovieModel.fromJson(json),
              keyJson: AppStrings.keyJsonResults);

      emit(
        TopRatedSucessState(
          topRatedMovies: responseMovies,
        ),
      );
    } catch (e) {
      emit(ErrorState());
    }
  }
}
