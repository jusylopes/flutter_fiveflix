import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fiveflix/blocs/popular_media_screen/popular_media_event.dart';
import 'package:flutter_fiveflix/blocs/popular_media_screen/popular_media_state.dart';
import 'package:flutter_fiveflix/models/popular_movie_model.dart';
import 'package:flutter_fiveflix/models/popular_serie_model.dart';
import 'package:flutter_fiveflix/repositories/media_repository.dart';

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
          await _repository.getPopularMovies();

      final List<PopularSerieModel> responseSeries =
          await _repository.getPopularSeries();

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
