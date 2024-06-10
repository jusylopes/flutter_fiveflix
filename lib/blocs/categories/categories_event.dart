part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();
}

class MediaCategoriesFetchEvent extends CategoriesEvent {
  const MediaCategoriesFetchEvent({
    required this.id,
    required this.mediaType,
  });

  final int id;
  final String mediaType;
  @override
  List<Object> get props => [id, mediaType];
}

class MediaByCategoriesFetchEvent extends CategoriesEvent {
  const MediaByCategoriesFetchEvent({
    required this.idGenre,
  });

  final int idGenre;

  @override
  List<Object> get props => [idGenre];
}

class ListCategoriesFetchEvent extends CategoriesEvent {
  const ListCategoriesFetchEvent();

  @override
  List<Object> get props => [];
}
