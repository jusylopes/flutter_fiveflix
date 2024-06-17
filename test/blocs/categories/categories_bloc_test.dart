import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_fiveflix/blocs/blocs_exports.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/utils/fiveflix_strings.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../mocks/mock_exports.dart';

void main() {
  group('Categories Bloc Test |', () {
    final mockMediaRepository = MockMediaRepository();
    final genres = <GenreModel>[
      GenreModel(id: 28, name: "Action"),
      GenreModel(id: 12, name: "Adventure"),
    ];
    const int idGenre = 28;
    const String mediaType = 'movie';
    final List<MediaModel> itemMedias = [
      MediaModel(
        id: 653346,
        title: 'Test Movie',
        genreIds: [
          878,
          12,
          28,
        ],
        voteAverage: 6.884,
        overview: "Kingdom of the Planet of the Apes",
        releaseDate: DateTime(2024 - 05 - 08),
        popularity: 5120.32,
        posterPath: "/gKkl37BQuKTanygYQG1pyYgLVgf.jpg",
        voteCount: 843,
        backdropPath: "/fqv8v6AycXKsivp1T5yKtLbGXce.jpg",
      ),
    ];

    blocTest<CategoriesBloc, CategoriesState>(
      'emits [CategoriesLoadingState, MediaCategoriesSucessState] when [MediaCategoriesFetchEvent] is added and fetch success.',
      setUp: () {
        when(mockMediaRepository.getListMedia(
          endpoint: FiveflixStrings.endpointGenre +
              mediaType +
              FiveflixStrings.endpointList,
          fromJson: anyNamed('fromJson'),
          keyJson: FiveflixStrings.keyJsonGenre,
        )).thenAnswer((_) async => genres);
      },
      build: () => CategoriesBloc(repository: mockMediaRepository),
      act: (bloc) => bloc.add(
        const MediaCategoriesFetchEvent(
          id: idGenre,
          mediaType: mediaType,
        ),
      ),
      expect: () => <CategoriesState>[
        CategoriesLoadingState(),
        MediaCategoriesSucessState(genres: genres)
      ],
    );

    blocTest<CategoriesBloc, CategoriesState>(
      'emits [CategoriesLoadingState, CategoriesErrorState] when [MediaCategoriesFetchEvent] is added and fetch fails.',
      setUp: () {
        when(mockMediaRepository.getListMedia(
          endpoint: FiveflixStrings.endpointGenre +
              mediaType +
              FiveflixStrings.endpointList,
          fromJson: anyNamed('fromJson'),
          keyJson: FiveflixStrings.keyJsonGenre,
        )).thenThrow(Exception());
      },
      build: () => CategoriesBloc(repository: mockMediaRepository),
      act: (bloc) => bloc.add(
        const MediaCategoriesFetchEvent(
          id: idGenre,
          mediaType: mediaType,
        ),
      ),
      expect: () => <CategoriesState>[
        CategoriesLoadingState(),
        CategoriesErrorState(Exception().toString()),
      ],
    );

    blocTest<CategoriesBloc, CategoriesState>(
      'emits [CategoriesLoadingState, MediaByCategoriesSucessState] when [MediaByCategoriesFetchEvent] is added success.',
      setUp: () {
        when(mockMediaRepository.getListMedia(
          endpoint: FiveflixStrings.endpointDiscoverGenre + idGenre.toString(),
          fromJson: anyNamed('fromJson'),
          keyJson: FiveflixStrings.keyJsonResults,
        )).thenAnswer((_) async => itemMedias);
      },
      build: () => CategoriesBloc(repository: mockMediaRepository),
      act: (bloc) => bloc.add(
        const MediaByCategoriesFetchEvent(
          idGenre: idGenre,
        ),
      ),
      expect: () => <CategoriesState>[
        CategoriesLoadingState(),
        MediaByCategoriesSucessState(medias: itemMedias)
      ],
    );

    blocTest<CategoriesBloc, CategoriesState>(
      'emits [CategoriesLoadingState, CategoriesErrorState] when [MediaByCategoriesFetchEvent] is added and fetch fails.',
      setUp: () {
        when(mockMediaRepository.getListMedia(
          endpoint: FiveflixStrings.endpointDiscoverGenre + idGenre.toString(),
          fromJson: anyNamed('fromJson'),
          keyJson: FiveflixStrings.keyJsonResults,
        )).thenThrow(Exception());
      },
      build: () => CategoriesBloc(repository: mockMediaRepository),
      act: (bloc) => bloc.add(
        const MediaByCategoriesFetchEvent(
          idGenre: idGenre,
        ),
      ),
      expect: () => <CategoriesState>[
        CategoriesLoadingState(),
        CategoriesErrorState(Exception().toString()),
      ],
    );

    blocTest<CategoriesBloc, CategoriesState>(
      'emits [CategoriesLoadingState, MediaCategoriesSucessState] when [ListCategoriesFetchEvent] is added.',
      setUp: () {
        when(mockMediaRepository.getListMedia(
                endpoint: FiveflixStrings.endpointGenreList,
                fromJson: anyNamed('fromJson'),
                keyJson: FiveflixStrings.keyJsonGenre))
            .thenAnswer((_) async => genres);
      },
      build: () => CategoriesBloc(repository: mockMediaRepository),
      act: (bloc) => bloc.add(
        const ListCategoriesFetchEvent(),
      ),
      expect: () => <CategoriesState>[
        CategoriesLoadingState(),
        MediaCategoriesSucessState(genres: genres)
      ],
    );

    blocTest<CategoriesBloc, CategoriesState>(
      'emits [CategoriesLoadingState, CategoriesErrorState] when [ListCategoriesFetchEvent] is added and fetch fails.',
      setUp: () {
        when(mockMediaRepository.getListMedia(
                endpoint: FiveflixStrings.endpointGenreList,
                fromJson: anyNamed('fromJson'),
                keyJson: FiveflixStrings.keyJsonGenre))
            .thenThrow(Exception());
      },
      build: () => CategoriesBloc(repository: mockMediaRepository),
      act: (bloc) => bloc.add(
        const ListCategoriesFetchEvent(),
      ),
      expect: () => <CategoriesState>[
        CategoriesLoadingState(),
        CategoriesErrorState(Exception().toString()),
      ],
    );
  });
}
