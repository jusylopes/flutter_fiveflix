import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fiveflix/blocs/movies/popular/popular_event.dart';
import 'package:flutter_fiveflix/blocs/movies/popular/popular_state.dart';
import 'package:flutter_fiveflix/models/popular_movie_model.dart';
import 'package:flutter_fiveflix/repositories/media_repository.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final MediaRepository _repository;

  PopularMovieBloc({required MediaRepository repository})
      : _repository = repository,
        super(InitialState()) {
    on<PopularMovieFetchEvent>((event, emit) async {
      emit(LoadingState());

      try {
        final List<PopularMovieModel> response =
            await _repository.getPopularMovies();
        emit(SuccessState(popularMovies: response));
      } catch (e) {
        emit(ErrorState());
      }
    });
  }
}
