import 'package:flutter_fiveflix/blocs/bloc_exports.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/repositories/media_repository.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final MediaRepository _repository;

  FavoriteBloc({required MediaRepository repository})
      : _repository = repository,
        super(InitialState()) {
    on<StartDatabaseEvent>(_onStartDatabaseEvent);
    on<FavoriteGetEvent>(_onFavoriteGetEvent);
    on<FavoriteSaveEvent>(_onFavoriteSaveEvent);
    on<FavoriteDeleteEvent>(_onFavoriteDeleteEvent);
  }

  void _onStartDatabaseEvent(
      StartDatabaseEvent event, Emitter<FavoriteState> emit) async {
    emit(LoadingState());

    try {} catch (e) {
      emit(ErrorState());
    }
  }

  void _onFavoriteGetEvent(
      FavoriteGetEvent event, Emitter<FavoriteState> emit) async {
    emit(LoadingState());

    try {} catch (e) {
      emit(ErrorState());
    }
  }

  void _onFavoriteSaveEvent(
      FavoriteSaveEvent event, Emitter<FavoriteState> emit) async {
    emit(LoadingState());

    try {} catch (e) {
      emit(ErrorState());
    }
  }

  void _onFavoriteDeleteEvent(
      FavoriteDeleteEvent event, Emitter<FavoriteState> emit) async {
    emit(LoadingState());

    try {} catch (e) {
      emit(ErrorState());
    }
  }
}
