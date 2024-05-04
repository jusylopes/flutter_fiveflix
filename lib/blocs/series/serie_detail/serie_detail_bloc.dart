import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fiveflix/blocs/series/serie_detail/serie_detail_event.dart';
import 'package:flutter_fiveflix/blocs/series/serie_detail/serie_detail_state.dart';
import 'package:flutter_fiveflix/models/serie_detail.dart';

import 'package:flutter_fiveflix/repositories/media_repository.dart';

class SerieDetailBloc extends Bloc<SerieDetailEvent, SerieDetailState> {
  final MediaRepository _repository;

  SerieDetailBloc({required MediaRepository repository})
      : _repository = repository,
        super(InitialState()) {
    on<SerieDetailFetchEvent>((event, emit) async {
      emit(LoadingState());

      try {
        final SerieDetailModel response =
            await _repository.getSerieDetail(id: event.id);

        emit(SuccessState(serie: response));
      } catch (e) {
        emit(ErrorState());
      }
    });
  }
}
