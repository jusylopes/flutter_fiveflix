part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();
}

class CategoriesFetchEvent extends CategoriesEvent {
  const CategoriesFetchEvent({
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
    required this.mediaType,
  });

  final int idGender;
  final String mediaType;
  @override
  List<Object> get props => [idGender, mediaType];
}
