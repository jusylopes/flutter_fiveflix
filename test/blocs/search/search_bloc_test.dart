import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_fiveflix/blocs/bloc_exports.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/repositories/media_repository.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../categories/categories_bloc_test.mocks.dart';

@GenerateMocks([MediaRepository])
void main() {
  group('Search Bloc Tests |', () {
    late MockMediaRepository mockMediaRepository;
    late List<MediaModel> itemsMedias;
    const String query = 'test';

    setUp(() {
      mockMediaRepository = MockMediaRepository();

      itemsMedias = [
        MediaModel(
            id: 1,
            title: 'Test Movie',
            genreIds: [1, 2],
            voteAverage: 8.0,
            overview: 'Test Overview',
            releaseDate: DateTime(1999 - 09 - 02),
            popularity: 2,
            posterPath: '',
            voteCount: 2,
            backdropPath: ''),
        MediaModel(
            id: 2,
            title: 'Test Movie',
            genreIds: [1, 2],
            voteAverage: 8.0,
            overview: 'Test Overview',
            releaseDate: DateTime(1999 - 09 - 02),
            popularity: 2,
            posterPath: '',
            voteCount: 2,
            backdropPath: ''),
      ];
    });

    blocTest<SearchBloc, SearchState>(
      'emits [SearchLoading, SearchSuccess] when [Search] is added and fetch success.',
      build: () {
        when(mockMediaRepository.getListMedia(
                endpoint: FiveflixStrings.endpointSearch + query,
                fromJson: anyNamed('fromJson'),
                keyJson: FiveflixStrings.keyJsonResults))
            .thenAnswer((_) async => itemsMedias);
        return SearchBloc(repository: mockMediaRepository);
      },
      act: (bloc) => bloc.add(const Search(query: query)),
      expect: () => <SearchState>[
        SearchLoading(),
        SearchSuccess(searchResult: itemsMedias),
      ],
    );

    blocTest<SearchBloc, SearchState>(
      'emits [SearchLoading, SearchSuccess] when [Search] is added and fetch fails.',
      build: () {
        when(mockMediaRepository.getListMedia(
                endpoint: FiveflixStrings.endpointSearch + query,
                fromJson: anyNamed('fromJson'),
                keyJson: FiveflixStrings.keyJsonResults))
            .thenThrow(Exception());
        return SearchBloc(repository: mockMediaRepository);
      },
      act: (bloc) => bloc.add(const Search(query: query)),
      expect: () => <SearchState>[
        SearchLoading(),
        SearchError(Exception().toString()),
      ],
    );
  });
}
