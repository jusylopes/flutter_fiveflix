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
    late List<MediaModel> mediaList;
    const String query = 'Kingdom';

    setUp(() {
      mockMediaRepository = MockMediaRepository();

      mediaList = [
        MediaModel(
            id: 653346,
            title: "Kingdom of the Planet of the Apes",
            genreIds: [
              878,
              12,
              28,
            ],
            voteAverage: 8.0,
            overview:
                "Several generations in the future following Caesar's reign, apes are now the dominant species and live harmoniously while humans have been reduced to living in the shadows. As a new tyrannical ape leader builds his empire, one young ape undertakes a harrowing journey that will cause him to question all that he has known about the past and to make choices that will define a future for apes and humans alike.",
            releaseDate: DateTime(2024 - 05 - 08),
            popularity: 5120.32,
            posterPath: "/gKkl37BQuKTanygYQG1pyYgLVgf.jpg",
            voteCount: 843,
            backdropPath: "/fqv8v6AycXKsivp1T5yKtLbGXce.jpg"),
      ];
    });

    blocTest<SearchBloc, SearchState>(
      'emits [SearchLoading, SearchSuccess] when [Search] is added and fetch success.',
      build: () {
        when(mockMediaRepository.getListMedia(
                endpoint: FiveflixStrings.endpointSearch + query,
                fromJson: anyNamed('fromJson'),
                keyJson: FiveflixStrings.keyJsonResults))
            .thenAnswer((_) async => mediaList);
        return SearchBloc(repository: mockMediaRepository);
      },
      act: (bloc) => bloc.add(const Search(query: query)),
      expect: () => <SearchState>[
        SearchLoading(),
        SearchSuccess(searchResult: mediaList),
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
