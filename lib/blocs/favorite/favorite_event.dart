part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();
}

class FavoriteSaveEvent<FavoriteModel> extends FavoriteEvent {
  const FavoriteSaveEvent({required this.item});

  final FavoriteModel item;


  @override
  List<Object?> get props => [item];
}

class FavoriteDeleteEvent extends FavoriteEvent {
  const FavoriteDeleteEvent({required this.id});

  final int id;

  @override
  List<Object> get props => [id];
}

class FavoriteGetAllEvent extends FavoriteEvent {
  const FavoriteGetAllEvent();

  @override
  List<Object> get props => [];
}
