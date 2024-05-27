part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {}

class FavoriteInitialState extends FavoriteState {
  @override
  List<Object> get props => [];
}

class FavoriteLoadingState extends FavoriteState {
  @override
  List<Object> get props => [];
}

class FavoriteItemAddedState extends FavoriteState {
  final FavoriteModel item;

  FavoriteItemAddedState({required this.item});

  @override
  List<Object> get props => [item];
}

class FavoriteItemRemovedState extends FavoriteState {
  @override
  List<Object> get props => [];
}

class FavoriteGetAllSuccessState<T> extends FavoriteState {
  final List<T> items;

  FavoriteGetAllSuccessState({required this.items});

  @override
  List<Object> get props => [items];
}

class FavoriteErrorState extends FavoriteState {
  final String message;

  FavoriteErrorState(this.message);

  @override
  List<Object> get props => [message];
}
