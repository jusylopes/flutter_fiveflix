part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();
}

class FavoriteToggleEvent<FavoriteModel> extends FavoriteEvent {
  const FavoriteToggleEvent({required this.item, required this.id});

  final FavoriteModel item;
  final int id;

  @override
  List<Object?> get props => [item, id];
}

class FavoriteGetAllEvent extends FavoriteEvent {
  const FavoriteGetAllEvent();

  @override
  List<Object> get props => [];
}
