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
    on<FavoriteToggleEvent>(_onFavoriteToggleEvent);
    on<FavoriteGetAllEvent>(_onFavoriteGetAllEvent);
    on<FavoriteRemoveEvent>(_onFavoriteRemoveEvent);
  }

  void _onFavoriteToggleEvent(
      FavoriteToggleEvent event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoadingState());

    final List favoriteList = await _repository.getAllMedias();
    final bool isFavorite = _isItemFavoriteInList(favoriteList, event.id);

    try {
      if (isFavorite) {
        await _repository.deleteMedia(event.id);
        emit(FavoriteItemRemovedState());
      } else {
        await _repository.saveMedia(event.item);
        emit(FavoriteItemAddedState(item: event.item));
      }
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

  void _onFavoriteRemoveEvent(
      FavoriteRemoveEvent event, Emitter<FavoriteState> emit) async {
    //emit(FavoriteLoadingState());

    try {
      await _repository.deleteMedia(event.id);
      emit(FavoriteItemRemovedState());
    } catch (e) {
      emit(FavoriteErrorState(e.toString()));
    }
  }

  bool _isItemFavoriteInList(List listFavorite, int id) {
    return listFavorite.any((item) => item.id == id);
  }
}
