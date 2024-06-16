import 'package:flutter_fiveflix/repositories/media_repository.dart';
import 'package:flutter_fiveflix/blocs/blocs_exports.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final MediaRepository _repository;

  CategoriesBloc({required MediaRepository repository})
      : _repository = repository,
        super(CategoriesInitialState()) {
    on<MediaCategoriesFetchEvent>(_onMediaCategoriesFetchEvent);
    on<MediaByCategoriesFetchEvent>(_onMediaByCategoriesFetchEvent);
    on<ListCategoriesFetchEvent>(_onMediaListCategoriesFetchEvent);
  }

  void _onMediaCategoriesFetchEvent(
      MediaCategoriesFetchEvent event, Emitter<CategoriesState> emit) async {
    emit(CategoriesLoadingState());

    try {
      final List<GenreModel> genres = await _repository.getListMedia(
          endpoint: FiveflixStrings.endpointGenre +
              event.mediaType +
              FiveflixStrings.endpointList,
          fromJson: (json) => GenreModel.fromJson(json),
          keyJson: FiveflixStrings.keyJsonGenre);

      emit(
        MediaCategoriesSucessState(
          genres: genres,
        ),
      );
    } catch (e) {
      emit(
        CategoriesErrorState(e.toString()),
      );
    }
  }

  void _onMediaByCategoriesFetchEvent(
      MediaByCategoriesFetchEvent event, Emitter<CategoriesState> emit) async {
    emit(CategoriesLoadingState());

    try {
      final List<MediaModel> medias = await _repository.getListMedia(
          endpoint:
              FiveflixStrings.endpointDiscoverGenre + event.idGenre.toString(),
          fromJson: (json) => MediaModel.fromJson(json),
          keyJson: FiveflixStrings.keyJsonResults);

      emit(
        MediaByCategoriesSucessState(medias: medias),
      );
    } catch (e) {
      emit(
        CategoriesErrorState(e.toString()),
      );
    }
  }

  void _onMediaListCategoriesFetchEvent(
      ListCategoriesFetchEvent event, Emitter<CategoriesState> emit) async {
    emit(CategoriesLoadingState());

    try {
      final List<GenreModel> genres = await _repository.getListMedia(
          endpoint: FiveflixStrings.endpointGenreList,
          fromJson: (json) => GenreModel.fromJson(json),
          keyJson: FiveflixStrings.keyJsonGenre);

      emit(
        MediaCategoriesSucessState(
          genres: genres,
        ),
      );
    } catch (e) {
      emit(
        CategoriesErrorState(e.toString()),
      );
    }
  }
}
