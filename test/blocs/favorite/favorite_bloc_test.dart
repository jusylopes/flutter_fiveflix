import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_fiveflix/blocs/bloc_exports.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../mocks/mock_exports.dart';

void main() {
  group('Favorite Bloc Test |', () {
    late MockFavoriteRepository mockFavoriteRepository;
    late MediaModel favoriteItem;
    late List favoriteList;

    setUpAll(() {
      mockFavoriteRepository = MockFavoriteRepository();
      favoriteItem = MediaModel(
          id: 653346,
          title: "Kingdom of the Planet of the Apes",
          genreIds: [878, 12, 28],
          voteAverage: 8.0,
          overview:
              "Several generations in the future following Caesar's reign, apes are now the dominant species and live harmoniously while humans have been reduced to living in the shadows. As a new tyrannical ape leader builds his empire, one young ape undertakes a harrowing journey that will cause him to question all that he has known about the past and to make choices that will define a future for apes and humans alike.",
          releaseDate: DateTime(2024 - 05 - 08),
          popularity: 5120.32,
          posterPath: "/gKkl37BQuKTanygYQG1pyYgLVgf.jpg",
          voteCount: 843,
          backdropPath: "/fqv8v6AycXKsivp1T5yKtLbGXce.jpg");
      favoriteList = [favoriteItem];
    });

///////////////////////////////////////////////////[FavoriteToggleEvent] REMOVED FAVORITE TESTS
    blocTest<FavoriteBloc, FavoriteState>(
      'emits [FavoriteLoadingState, FavoriteCategoriesSucessState] when [FavoriteToggleEvent] is removed success.',
      setUp: () {
        when(mockFavoriteRepository.getAllMedias())
            .thenAnswer((_) async => [favoriteItem]);
        when(mockFavoriteRepository.deleteMedia(favoriteItem.id))
            .thenAnswer((_) async {});
      },
      build: () => FavoriteBloc(repository: mockFavoriteRepository),
      act: (bloc) => bloc.add(FavoriteToggleEvent(
        id: favoriteItem.id,
        item: favoriteItem,
      )),
      expect: () => <FavoriteState>[
        FavoriteLoadingState(),
        FavoriteItemRemovedState(),
      ],
    );

    blocTest<FavoriteBloc, FavoriteState>(
      'emits [FavoriteLoadingState, FavoriteCategoriesSucessState] when [FavoriteToggleEvent] is removed error.',
      setUp: () {
        when(mockFavoriteRepository.getAllMedias())
            .thenAnswer((_) async => [favoriteItem]);
        when(mockFavoriteRepository.deleteMedia(any)).thenThrow(Exception());
      },
      build: () => FavoriteBloc(repository: mockFavoriteRepository),
      act: (bloc) => bloc.add(FavoriteToggleEvent(
        id: favoriteItem.id,
        item: favoriteItem,
      )),
      expect: () => <FavoriteState>[
        FavoriteLoadingState(),
        FavoriteErrorState(Exception().toString()),
      ],
    );

///////////////////////////////////////////////////[FavoriteToggleEvent] ADDED FAVORITE TESTS
    blocTest<FavoriteBloc, FavoriteState>(
      'emits [FavoriteLoadingState, FavoriteCategoriesSucessState] when [FavoriteToggleEvent] is added success.',
      setUp: () {
        when(mockFavoriteRepository.getAllMedias()).thenAnswer((_) async => []);
        when(mockFavoriteRepository.saveMedia(favoriteItem))
            .thenAnswer((_) async {});
      },
      build: () => FavoriteBloc(repository: mockFavoriteRepository),
      act: (bloc) => bloc.add(FavoriteToggleEvent(
        id: favoriteItem.id,
        item: favoriteItem,
      )),
      expect: () => <FavoriteState>[
        FavoriteLoadingState(),
        FavoriteItemAddedState(
          item: favoriteItem,
        ),
      ],
    );

    blocTest<FavoriteBloc, FavoriteState>(
      'emits [FavoriteLoadingState, FavoriteCategoriesSucessState] when [FavoriteToggleEvent] is removed error.',
      setUp: () {
        when(mockFavoriteRepository.getAllMedias()).thenAnswer((_) async => []);
        when(mockFavoriteRepository.saveMedia(
          any,
        )).thenThrow(Exception());
      },
      build: () => FavoriteBloc(repository: mockFavoriteRepository),
      act: (bloc) => bloc.add(FavoriteToggleEvent(
        id: favoriteItem.id,
        item: favoriteItem,
      )),
      expect: () => <FavoriteState>[
        FavoriteLoadingState(),
        FavoriteErrorState(Exception().toString()),
      ],
    );

///////////////////////////////////////////////////[FavoriteGetAllEvent] TESTS
    blocTest<FavoriteBloc, FavoriteState>(
      'emits [FavoriteLoadingState, FavoriteCategoriesSucessState] when [FavoriteGetAllEvent] is added success.',
      setUp: () {
        when(mockFavoriteRepository.getAllMedias())
            .thenAnswer((_) async => favoriteList);
      },
      build: () => FavoriteBloc(repository: mockFavoriteRepository),
      act: (bloc) => bloc.add(const FavoriteGetAllEvent()),
      expect: () => <FavoriteState>[
        FavoriteLoadingState(),
        FavoriteGetAllSuccessState(items: favoriteList),
      ],
    );

    blocTest<FavoriteBloc, FavoriteState>(
      'emits [FavoriteLoadingState, FavoriteCategoriesSucessState] when [FavoriteGetAllEvent] is added and fetch fails.',
      build: () {
        when(mockFavoriteRepository.getAllMedias()).thenThrow(Exception());
        return FavoriteBloc(repository: mockFavoriteRepository);
      },
      act: (bloc) => bloc.add(const FavoriteGetAllEvent()),
      expect: () => <FavoriteState>[
        FavoriteLoadingState(),
        FavoriteErrorState(Exception().toString()),
      ],
    );

///////////////////////////////////////////////////[FavoriteRemoveEVent] TESTS
    blocTest<FavoriteBloc, FavoriteState>(
      'emits [FavoriteLoadingState, FavoriteCategoriesSucessState] when [FavoriteRemoveItemEvent] is added success.',
      setUp: () {
        when(mockFavoriteRepository.deleteMedia(favoriteItem.id))
            .thenAnswer((_) async => favoriteItem.id);
      },
      build: () => FavoriteBloc(repository: mockFavoriteRepository),
      act: (bloc) => bloc.add(
        FavoriteRemoveItemEvent(id: favoriteItem.id),
      ),
      expect: () => <FavoriteState>[
        FavoriteItemRemovedState(),
      ],
    );

    blocTest<FavoriteBloc, FavoriteState>(
      'emits [FavoriteLoadingState, FavoriteCategoriesSucessState] when [FavoriteRemoveItemEvent] is added success.',
      build: () {
        when(mockFavoriteRepository.deleteMedia(favoriteItem.id))
            .thenThrow(Exception());
        return FavoriteBloc(repository: mockFavoriteRepository);
      },
      act: (bloc) => bloc.add(
        FavoriteRemoveItemEvent(id: favoriteItem.id),
      ),
      expect: () => <FavoriteState>[
        FavoriteErrorState(Exception().toString()),
      ],
    );
  });
}
