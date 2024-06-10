import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_fiveflix/blocs/bloc_exports.dart';
import 'package:flutter_fiveflix/models/genre_model.dart';
import 'package:flutter_fiveflix/repositories/media_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'categories_bloc_test.mocks.dart';

@GenerateMocks([MediaRepository])
void main() {
  group('Categories Bloc Tests |', () {
    final mockRepository = MockMediaRepository();
    final genres = <GenreModel>[
      GenreModel(id: 28, name: "Action"),
      GenreModel(id: 12, name: "Adventure"),
    ];

    blocTest<CategoriesBloc, CategoriesState>(
      'emits [CategoriesLoadingState, MediaCategoriesSucessState] when [MediaCategoriesFetchEvent] is added and fetch success.',
      setUp: () {
        when(mockRepository.getListMedia(
          endpoint: 'https://api.themoviedb.org/3/genre/movie/list',
          fromJson: anyNamed('fromJson'),
          keyJson: 'genres',
        )).thenAnswer((_) async => genres);
      },
      build: () => CategoriesBloc(repository: mockRepository),
      act: (bloc) => bloc.add(
        const MediaCategoriesFetchEvent(
          id: 28,
          mediaType: 'movie',
        ),
      ),
      expect: () => <CategoriesState>[
        CategoriesLoadingState(),
        MediaCategoriesSucessState(genres: genres)
      ],
    );
  });
}
