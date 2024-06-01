import 'package:flutter_fiveflix/repositories/media_repository.dart';
import 'package:flutter_fiveflix/blocs/bloc_exports.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final MediaRepository _repository;

  CategoriesBloc({required MediaRepository repository})
      : _repository = repository,
        super(CategoriesInitialState()) {
    on<CategoriesFetchEvent>(_onCategoriesFetchEvent);
    on<MediaByCategoriesFetchEvent>(_onMediaByCategoriesFetchEvent);
  }

  void _onCategoriesFetchEvent(
      CategoriesFetchEvent event, Emitter<CategoriesState> emit) async {
    emit(CategoriesLoadingState());

    try {
      final List<GenreModel> genres = await _repository.getListMedia(
          endpoint: FiveflixStrings.endpointGenre +
              event.mediaType +
              FiveflixStrings.endpointList,
          fromJson: (json) => GenreModel.fromJson(json),
          keyJson: FiveflixStrings.keyJsonGenre);

      emit(
        CategoriesSucessState(
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
        endpoint: FiveflixStrings.endpointDiscoverGender +
            event.mediaType +
            FiveflixStrings.endpointGenre +
            event.idGender.toString(),
        fromJson: (json) => MediaModel.fromJson(json),
        keyJson: FiveflixStrings.keyJsonGenre);

    emit(
      MediaByCategoriesSucessState(medias: medias),
    );
  } catch (e) {
    emit(
      CategoriesErrorState(e.toString()),
    );
  }
}
}