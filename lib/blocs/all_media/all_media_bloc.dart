import 'package:flutter_fiveflix/blocs/blocs_exports.dart';
import 'package:flutter_fiveflix/repositories/media_repository.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/screens/all_medias/all_media_type.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

part 'all_media_event.dart';
part 'all_media_state.dart';

class AllMediaBloc extends Bloc<AllMediaEvent, AllMediaState> {
  final MediaRepository _repository;
  int currentPage = 1;
  bool isFetching = false;

  AllMediaBloc({required MediaRepository allMediaRepository})
      : _repository = allMediaRepository,
        super(AllMediaInitialState()) {
    on<AllMediaFetchEvent>(_onAllMediaFetchEvent);
    on<ResetAllMediaEvent>(_onResetAllMediaEvent);
  }

  void _onAllMediaFetchEvent(
      AllMediaFetchEvent event, Emitter<AllMediaState> emit) async {
    emit(ALLMediaLoadingState());
    isFetching = true;

    try {
      final List<MediaModel> allMedias = await _repository.getListMedia(
          endpoint: _fetchMedia(
              mediaType: event.mediaType,
              page: currentPage,
              idGenre: event.idGenre),
          fromJson: (json) => MediaModel.fromJson(json),
          keyJson: FiveflixStrings.keyJsonResults);

      isFetching = false;

      emit(
        AllMediaSuccessState(
          allMedias: allMedias,
        ),
      );
      currentPage++;
    } catch (e) {
      isFetching = false;
      emit(
        AllMediaErrorState(e.toString()),
      );
    }
  }

  void _onResetAllMediaEvent(
      ResetAllMediaEvent event, Emitter<AllMediaState> emit) {
    currentPage = 1;

    emit(AllMediaInitialState());
    isFetching = true;
  }

  String _fetchMedia({
    required AllMediaType mediaType,
    required int page,
    String idGenre = '',
  }) {
    switch (mediaType) {
      case AllMediaType.popularMovie:
        return '${FiveflixStrings.endpointPopularMovies}?page=$page';
      case AllMediaType.popularSerie:
        return '${FiveflixStrings.endpointPopularSeries}?page=$page';
      case AllMediaType.topRatedSerie:
        return '${FiveflixStrings.endpointTopRated}?page=$page';
      case AllMediaType.upComingMovie:
        return '${FiveflixStrings.endpointUpcoming}?page=$page';
      case AllMediaType.discoverGenre:
        return '${FiveflixStrings.endpointDiscoverGenre}$idGenre?page=$page';
      default:
        throw Exception('Unknown media type');
    }
  }
}
