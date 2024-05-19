import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fiveflix/models/popular_movie_model.dart';
import 'package:flutter_fiveflix/models/popular_serie_model.dart';
import 'package:flutter_fiveflix/repositories/media_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fiveflix/utils/api_base_options.dart';
part 'popular_media_event.dart';
part 'popular_media_state.dart';

class PopularMediaBloc extends Bloc<PopularMediaEvent, PopularMediaState> {
  final MediaRepository _repository;

  PopularMediaBloc({required MediaRepository repository})
      : _repository = repository,
        super(InitialState()) {
    on<PopularMediaFetchEvent>(_onPopularMovieFetchEvent);
  }

  void _onPopularMovieFetchEvent(
      PopularMediaFetchEvent event, Emitter<PopularMediaState> emit) async {
    emit(LoadingState());

    try {
      final List<PopularMovieModel> responseMovies =
          await _repository.getListMedia(
        endpoint: endpointPopularMovies,
        fromJson: (json) => PopularMovieModel.fromJson(json),
      );

      final List<PopularSerieModel> responseSeries =
          await _repository.getListMedia(
        endpoint: endpointPopularSeries,
        fromJson: (json) => PopularSerieModel.fromJson(json),
      );

      emit(
        SuccessState(
          popularMovies: responseMovies,
          popularSeries: responseSeries,
        ),
      );
    } catch (e) {
      emit(ErrorState());
    }
  }
}
