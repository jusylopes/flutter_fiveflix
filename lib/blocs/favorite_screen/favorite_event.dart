part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();
}

class FavoriteGetEvent extends FavoriteEvent {
  const FavoriteGetEvent({required this.id});

  final int id;

  @override
  List<Object> get props => [id];
}

class FavoriteSaveEvent extends FavoriteEvent {
  const FavoriteSaveEvent({required this.id});

  final int id;

  @override
  List<Object> get props => [id];
}

class FavoriteDeleteEvent extends FavoriteEvent {
  const FavoriteDeleteEvent({required this.id});

  final int id;

  @override
  List<Object> get props => [id];
}

class StartDatabaseEvent extends FavoriteEvent {
  const StartDatabaseEvent({required this.id});

  final int id;

  @override
  List<Object> get props => [id];
}
