import 'package:flutter_fiveflix/blocs/bloc_exports.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/repositories/local_media_repository.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final LocalMediaRepository _repository;

  FavoriteBloc({required LocalMediaRepository repository})
      : _repository = repository,
        super(FavoriteInitialState()) {
    on<FavoriteSaveEvent>(_onFavoriteSaveEvent);
    on<FavoriteDeleteEvent>(_onFavoriteDeleteEvent);
    on<FavoriteGetAllEvent>(_onFavoriteGetAllEvent);
  }

  void _onFavoriteSaveEvent(
      FavoriteSaveEvent event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoadingState());

    try {
      await _repository.saveMedia(event.item);

      emit(FavoriteItemSuccessState(item: event.item));
    } catch (e) {
      emit(FavoriteErrorState(e.toString()));
    }
  }

  void _onFavoriteDeleteEvent(
      FavoriteDeleteEvent event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoadingState());
    try {
      await _repository.deleteMedia(event.id);
      emit(FavoriteDeleteSuccessState());
    } catch (e) {
      emit(FavoriteErrorState(e.toString()));
    }
  }

  void _onFavoriteGetAllEvent(
      FavoriteGetAllEvent event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoadingState());
    try {
      
      final List items = await _repository.getAllMedias();
      
      emit(FavoriteGetAllSuccessState(items: items));
    } catch (e) {
      emit(FavoriteErrorState(e.toString()));
    }
  }
}
