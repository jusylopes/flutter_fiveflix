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
    required this.idGender,
  });

  final int idGender;

  @override
  List<Object> get props => [idGender];
}

class ListCategoriesFetchEvent extends CategoriesEvent {
  const ListCategoriesFetchEvent();

  @override
  List<Object> get props => [];
}
