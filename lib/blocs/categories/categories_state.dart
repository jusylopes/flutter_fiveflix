part of 'categories_bloc.dart';

abstract class CategoriesState extends Equatable {}

class CategoriesInitialState extends CategoriesState {
  @override
  List<Object> get props => [];
}

class CategoriesLoadingState extends CategoriesState {
  @override
  List<Object> get props => [];
}

class MediaCategoriesSucessState extends CategoriesState {
  MediaCategoriesSucessState({
    required this.genres,
  });

  final List<GenreModel> genres;

  @override
  List<Object> get props => [genres];
}

class MediaByCategoriesSucessState extends CategoriesState {
  MediaByCategoriesSucessState({
    required this.medias,
  });

  final List<MediaModel> medias;

  @override
  List<Object> get props => [medias];
}

class CategoriesErrorState extends CategoriesState {
  final String errorMessage;

  CategoriesErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
