import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_fiveflix/blocs/bloc_exports.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../mocks/mock_exports.dart';

void main() {
  group('Medias Bloc Tests |', () {
    late MockMediaRepository mockMediaRepository;
    late MediaModel itemMediaMovie;
    late MediaModel itemMediaSerie;
    late List<MediaModel> popularMovies;
    late List<MediaModel> upcomingMovies;
    late List<MediaModel> popularSeries;
    late List<MediaModel> topRatedSeries;
    late List<MediaModel> newsMovies;
    late List<CastModel> castList;
    late List<VideoModel> trailerList;
    const String movieType = 'movie';

    setUpAll(() {
      mockMediaRepository = MockMediaRepository();
      itemMediaMovie = MediaModel(
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
          backdropPath: "/fqv8v6AycXKsivp1T5yKtLbGXce.jpg");
      itemMediaSerie = MediaModel(
          id: 2734,
          title: "Law & Order: Special Victims Unit",
          genreIds: [
            80,
            18,
            9648,
          ],
          voteAverage: 7.918,
          overview:
              "In the criminal justice system, sexually-based offenses are considered especially heinous. In New York City, the dedicated detectives who investigate these vicious felonies are members of an elite squad known as the Special Victims Unit. These are their stories.",
          releaseDate: DateTime(1999 - 09 - 20),
          popularity: 4519.753,
          posterPath: "/onmSVwYsPMYtO8OjLdjS8FfRNKb.jpg",
          voteCount: 3695,
          backdropPath: "/hib8MpBPU7GdluS38htXCF4uw0c.jpg");

      popularMovies = [itemMediaMovie];
      newsMovies = [itemMediaMovie];
      upcomingMovies = [itemMediaMovie];
      popularSeries = [itemMediaSerie];
      topRatedSeries = [itemMediaSerie];
      castList = [
        CastModel(
          id: 1586047,
          name: "Owen Teague",
          profilePath: "/tgCkGE0LIggyjMmgSwHhpZAkfJs.jpg",
        ),
      ];
      trailerList = [
        VideoModel(
          name: "Number One",
          key: "68xkEZ4-nAs",
          id: "66550bc60f5968d3c61bbf59",
        )
      ];
    });

///////////////////////////////////////////////////[PopularMovieFetchEvent] TESTS
    blocTest<MediaBloc, MediaState>(
      'emits [MediaLoadingState, PopularMovieSuccessState] when [PopularMovieFetchEvent] is added success.',
      setUp: () {
        when(mockMediaRepository.getListMedia(
          endpoint: FiveflixStrings.endpointPopularMovies,
          fromJson: anyNamed('fromJson'),
          keyJson: FiveflixStrings.keyJsonResults,
        )).thenAnswer((_) async => popularMovies);

        when(mockMediaRepository.getListMedia(
          endpoint: FiveflixStrings.endpointUpcoming,
          fromJson: anyNamed('fromJson'),
          keyJson: FiveflixStrings.keyJsonResults,
        )).thenAnswer((_) async => upcomingMovies);
      },
      build: () => MediaBloc(repository: mockMediaRepository),
      act: (bloc) => bloc.add(
        PopularMovieFetchEvent(),
      ),
      expect: () => <MediaState>[
        MediaLoadingState(),
        PopularMovieSuccessState(
          popularMedias: popularMovies,
          upCommingMedias: upcomingMovies,
        ),
      ],
    );
    blocTest<MediaBloc, MediaState>(
      'emits [MediaLoadingState, PopularMovieSuccessState] when [PopularMovieFetchEvent] is added and fetch fails.',
      build: () {
        when(mockMediaRepository.getListMedia(
          endpoint: FiveflixStrings.endpointPopularMovies,
          fromJson: anyNamed('fromJson'),
          keyJson: FiveflixStrings.keyJsonResults,
        )).thenThrow(Exception());

        when(mockMediaRepository.getListMedia(
          endpoint: FiveflixStrings.endpointUpcoming,
          fromJson: anyNamed('fromJson'),
          keyJson: FiveflixStrings.keyJsonResults,
        )).thenThrow(Exception());
        return MediaBloc(repository: mockMediaRepository);
      },
      act: (bloc) => bloc.add(
        PopularMovieFetchEvent(),
      ),
      expect: () => <MediaState>[
        MediaLoadingState(),
        MediaErrorState(Exception().toString()),
      ],
    );

///////////////////////////////////////////////////[PopularSerieFetchEvent] TESTS
    blocTest<MediaBloc, MediaState>(
      'emits [MediaLoadingState, PopularSerieSuccessState] when [PopularSerieFetchEvent] is added success.',
      setUp: () {
        when(mockMediaRepository.getListMedia(
          endpoint: FiveflixStrings.endpointPopularSeries,
          fromJson: anyNamed('fromJson'),
          keyJson: FiveflixStrings.keyJsonResults,
        )).thenAnswer((_) async => popularSeries);

        when(mockMediaRepository.getListMedia(
          endpoint: FiveflixStrings.endpointTopRatedTV,
          fromJson: anyNamed('fromJson'),
          keyJson: FiveflixStrings.keyJsonResults,
        )).thenAnswer((_) async => topRatedSeries);
      },
      build: () => MediaBloc(repository: mockMediaRepository),
      act: (bloc) => bloc.add(
        PopularSerieFetchEvent(),
      ),
      expect: () => <MediaState>[
        MediaLoadingState(),
        PopularSerieSuccessState(
          popularMedias: popularSeries,
          topRatedTv: topRatedSeries,
        ),
      ],
    );
    blocTest<MediaBloc, MediaState>(
      'emits [MediaLoadingState, PopularSerieSuccessState] when [PopularSerieFetchEvent] is added and fetch fails.',
      build: () {
        when(mockMediaRepository.getListMedia(
          endpoint: FiveflixStrings.endpointPopularSeries,
          fromJson: anyNamed('fromJson'),
          keyJson: FiveflixStrings.keyJsonResults,
        )).thenThrow(Exception());

        when(mockMediaRepository.getListMedia(
          endpoint: FiveflixStrings.endpointTopRatedTV,
          fromJson: anyNamed('fromJson'),
          keyJson: FiveflixStrings.keyJsonResults,
        )).thenThrow(Exception());
        return MediaBloc(repository: mockMediaRepository);
      },
      act: (bloc) => bloc.add(
        PopularSerieFetchEvent(),
      ),
      expect: () => <MediaState>[
        MediaLoadingState(),
        MediaErrorState(Exception().toString()),
      ],
    );

///////////////////////////////////////////////////[NewsFetchEvent] TESTS
    blocTest<MediaBloc, MediaState>(
      'emits [MediaLoadingState, NewsSuccessState] when [NewsFetchEvent] is added success.',
      setUp: () {
        when(mockMediaRepository.getListMedia(
          endpoint: FiveflixStrings.endpointNews,
          fromJson: anyNamed('fromJson'),
          keyJson: FiveflixStrings.keyJsonResults,
        )).thenAnswer((_) async => newsMovies);
      },
      build: () => MediaBloc(repository: mockMediaRepository),
      act: (bloc) => bloc.add(
        NewsFetchEvent(),
      ),
      expect: () => <MediaState>[
        MediaLoadingState(),
        NewsSuccessState(
          newsMovies: newsMovies,
        ),
      ],
    );
    blocTest<MediaBloc, MediaState>(
      'emits [MediaLoadingState, NewsSuccessState] when [NewsFetchEvent] is added and fetch fails.',
      build: () {
        when(mockMediaRepository.getListMedia(
          endpoint: FiveflixStrings.endpointNews,
          fromJson: anyNamed('fromJson'),
          keyJson: FiveflixStrings.keyJsonResults,
        )).thenThrow(Exception());
        return MediaBloc(repository: mockMediaRepository);
      },
      act: (bloc) => bloc.add(
        NewsFetchEvent(),
      ),
      expect: () => <MediaState>[
        MediaLoadingState(),
        MediaErrorState(Exception().toString()),
      ],
    );

///////////////////////////////////////////////////[MediaDetailFetchEvent] TESTS
    blocTest<MediaBloc, MediaState>(
      'emits [MediaLoadingState, MediaDetailSucessState] when [MediaDetailFetchEvent] is added success.',
      setUp: () {
        when(mockMediaRepository.getListMedia(
          endpoint:
              '${FiveflixStrings.endpointMedia}$movieType/${itemMediaMovie.id}${FiveflixStrings.endpointCast}',
          fromJson: anyNamed('fromJson'),
          keyJson: FiveflixStrings.keyJsonCast,
        )).thenAnswer((_) async => castList);

        when(mockMediaRepository.getListMedia(
          endpoint:
              '${FiveflixStrings.endpointMedia}$movieType/${itemMediaMovie.id}${FiveflixStrings.endpointVideo}',
          fromJson: anyNamed('fromJson'),
          keyJson: FiveflixStrings.keyJsonResults,
        )).thenAnswer((_) async => trailerList);
      },
      build: () => MediaBloc(repository: mockMediaRepository),
      act: (bloc) => bloc.add(
        MediaDetailFetchEvent(id: itemMediaMovie.id, mediaType: movieType),
      ),
      expect: () => <MediaState>[
        MediaLoadingState(),
        MediaDetailSucessState(trailers: trailerList, casts: castList)
      ],
    );

    blocTest<MediaBloc, MediaState>(
      'emits [MediaLoadingState, MediaDetailSucessState] when [MediaDetailFetchEvent] is and fetch fails.',
      build: () {
        when(mockMediaRepository.getListMedia(
          endpoint:
              '${FiveflixStrings.endpointMedia}$movieType/${itemMediaMovie.id}${FiveflixStrings.endpointCast}',
          fromJson: anyNamed('fromJson'),
          keyJson: FiveflixStrings.keyJsonCast,
        )).thenThrow(Exception());

        when(mockMediaRepository.getListMedia(
          endpoint:
              '${FiveflixStrings.endpointMedia}$movieType/${itemMediaMovie.id}${FiveflixStrings.endpointVideo}',
          fromJson: anyNamed('fromJson'),
          keyJson: FiveflixStrings.keyJsonResults,
        )).thenThrow(Exception());

        return MediaBloc(repository: mockMediaRepository);
      },
      act: (bloc) => bloc.add(
        MediaDetailFetchEvent(id: itemMediaMovie.id, mediaType: movieType),
      ),
      expect: () => <MediaState>[
        MediaLoadingState(),
        MediaErrorState(Exception().toString()),
      ],
    );
  });
}
