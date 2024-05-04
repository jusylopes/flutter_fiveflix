import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fiveflix/blocs/series/popular/popular_event.dart';
import 'package:flutter_fiveflix/blocs/series/popular/popular_state.dart';
import 'package:flutter_fiveflix/models/popular_serie_model.dart';
import 'package:flutter_fiveflix/repositories/media_repository.dart';

class PopularSerieBloc extends Bloc<PopularSerieEvent, PopularSerieState> {
  final MediaRepository _repository;

  PopularSerieBloc({required MediaRepository repository})
      : _repository = repository,
        super(InitialState()) {
    on<PopularSerieFetchEvent>((event, emit) async {
      emit(LoadingState());

      try {
        final List<PopularSerieModel> response =
            await _repository.getPopularSeries();
        emit(SuccessState(popularSeries: response));
      } catch (e) {
        emit(ErrorState());
      }
    });
  }
}
