import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_fiveflix/blocs/bloc_exports.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/repositories/favorite_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'favorite_bloc_test.mocks.dart';

@GenerateMocks([FavoriteRepository])
void main() {
  group('Favorite Bloc |', () {
    late MockFavoriteRepository mockFavoriteRepository;
    late MediaModel favoriteItem;
    late List favoriteItems;

    setUp(() {
      mockFavoriteRepository = MockFavoriteRepository();
      favoriteItem = MediaModel(
        id: 1,
        title: 'Test Movie',
        genreIds: [1, 2],
        voteAverage: 8.0,
        overview: 'Test Overview',
        releaseDate: DateTime(1999, 9, 2),
        popularity: 2,
        posterPath: '',
        voteCount: 2,
        backdropPath: '',
      );
      favoriteItems = [favoriteItem];
    });

///// FavoriteToggleEvent()
    ///
///// FavoriteGetAllEvent()
    blocTest<FavoriteBloc, FavoriteState>(
      'emits [FavoriteLoadingState, FavoriteCategoriesSucessState] when [FavoriteGetAllEvent] is added success.',
      setUp: () {
        when(mockFavoriteRepository.getAllMedias())
            .thenAnswer((_) async => favoriteItems);
      },
      build: () => FavoriteBloc(repository: mockFavoriteRepository),
      act: (bloc) => bloc.add(const FavoriteGetAllEvent()),
      expect: () => <FavoriteState>[
        FavoriteLoadingState(),
        FavoriteGetAllSuccessState(items: favoriteItems),
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

    ///// FavoriteRemoveEVent()
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
