import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fiveflix/blocs/movies/movie_detail/movie_detail_event.dart';
import 'package:flutter_fiveflix/blocs/movies/movie_detail/movie_detail_state.dart';
import 'package:flutter_fiveflix/models/movie_detail_model.dart';
import 'package:flutter_fiveflix/repositories/media_repository.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final MediaRepository _repository;

  MovieDetailBloc({required MediaRepository repository})
      : _repository = repository,
        super(InitialState()) {
    on<MovieDetailFetchEvent>((event, emit) async {
      emit(LoadingState());

      try {
        final MovieDetailModel response =
            await _repository.getMovieDetail(id: event.id);

        emit(SuccessState(movie: response));
      } catch (e) {
        emit(ErrorState());
      }
    });
  }
}
