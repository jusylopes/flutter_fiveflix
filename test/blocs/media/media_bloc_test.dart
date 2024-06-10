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
  group('Medias Bloc Tests |', () {
    final mockMediaRepository = MockMediaRepository();
    final List<MediaModel> popularMovies = [
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
    final List<MediaModel> upCommingMovies = [
      MediaModel(
          id: 573435,
          title: "Bad Boys: Ride or Die",
          genreIds: [28, 80, 53],
          voteAverage: 7.643,
          overview:
              "After their late former Captain is framed, Lowrey and Burnett try to clear his name, only to end up on the run themselves.",
          releaseDate: DateTime(2024 - 06 - 05),
          popularity: 1776.083,
          posterPath: "/nP6RliHjxsz4irTKsxe8FRhKZYl.jpg",
          voteCount: 91,
          backdropPath: "/ga4OLm4qLxPqKLMzjJlqHxVjst3.jpg"),
    ];
    final List<MediaModel> popularSeries = [
      MediaModel(
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
          backdropPath: "/hib8MpBPU7GdluS38htXCF4uw0c.jpg"),
    ];
    final List<MediaModel> topRatedSeries = [
      MediaModel(
          id: 1396,
          title: "Breaking Bad",
          genreIds: [18, 80],
          voteAverage: 8.908,
          overview:
              "Walter White, a New Mexico chemistry teacher, is diagnosed with Stage III cancer and given a prognosis of only two years left to live. He becomes filled with a sense of fearlessness and an unrelenting desire to secure his family's financial future at any cost as he enters the dangerous world of drugs and crime.",
          releaseDate: DateTime(2008 - 01 - 20),
          popularity: 564.508,
          posterPath: "/ztkUQFLlC19CCMYHW9o1zWhJRNq.jpg",
          voteCount: 3695,
          backdropPath: "/9faGSFi5jam6pDWGNd0p8JcJgXQ.jpg"),
    ];
    final List<MediaModel> responseMovies = [];
    final List<MediaModel> casts = [];
    final List<MediaModel> trailers = [];

// Movies Test //
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
        )).thenAnswer((_) async => upCommingMovies);
      },
      build: () => MediaBloc(repository: mockMediaRepository),
      act: (bloc) => bloc.add(
        PopularMovieFetchEvent(),
      ),
      expect: () => <MediaState>[
        MediaLoadingState(),
        PopularMovieSuccessState(
          popularMedias: popularMovies,
          upCommingMedias: upCommingMovies,
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

    /// Series and Top Rated Test //
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

// News Test //
    blocTest<MediaBloc, MediaState>(
      'emits [MediaLoadingState, NewsSuccessState] when [NewsFetchEvent] is added success.',
      setUp: () {
        when(mockMediaRepository.getListMedia(
          endpoint: FiveflixStrings.endpointNews,
          fromJson: anyNamed('fromJson'),
          keyJson: FiveflixStrings.keyJsonResults,
        )).thenAnswer((_) async => responseMovies);
      },
      build: () => MediaBloc(repository: mockMediaRepository),
      act: (bloc) => bloc.add(
        NewsFetchEvent(),
      ),
      expect: () => <MediaState>[
        MediaLoadingState(),
        NewsSuccessState(
          newsMovies: responseMovies,
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

// Medialdetail Test //
    // blocTest<MediaBloc, MediaState>(
    //   'emits [MediaLoadingState, MediaDetailSucessState] when [MediaDetailFetchEvent] is added success.',
    //   setUp: () {
    //     when(mockMediaRepository.getListMedia(
    //       endpoint:
    //           '${FiveflixStrings.endpointMedia}${event.mediaType}/${event.id}${FiveflixStrings.endpointCast}',
    //       fromJson: anyNamed('fromJson'),
    //       keyJson: FiveflixStrings.keyJsonResults,
    //     )).thenAnswer((_) async => casts);

    //     when(mockMediaRepository.getListMedia(
    //       endpoint:
    //           '${FiveflixStrings.endpointMedia}${event.mediaType}/${event.id}${FiveflixStrings.endpointTrailer}',
    //       fromJson: anyNamed('fromJson'),
    //       keyJson: FiveflixStrings.keyJsonResults,
    //     )).thenAnswer((_) async => trailers);
    //   },
    //   build: () => MediaBloc(repository: mockMediaRepository),
    //   act: (bloc) => bloc.add(
    //     MediaDetailFetchEvent(),
    //   ),
    //   expect: () => <MediaState>[
    //     MediaLoadingState(),
    //     MediaDetailFetchEvent(
    //       casts: casts,
    //       trailers: trailers,
    //     ),
    //   ],
    // );
    // blocTest<MediaBloc, MediaState>(
    //   'emits [MediaLoadingState, MediaDetailSucessState] when [MediaDetailFetchEvent] is added and fetch fails.',
    //   build: () {
    //     when(mockMediaRepository.getListMedia(
    //       endpoint:
    //           '${FiveflixStrings.endpointMedia}${event.mediaType}/${event.id}${FiveflixStrings.endpointCast}',
    //       fromJson: anyNamed('fromJson'),
    //       keyJson: FiveflixStrings.keyJsonResults,
    //     )).thenThrow(Exception());

    //     when(mockMediaRepository.getListMedia(
    //       endpoint:
    //           '${FiveflixStrings.endpointMedia}${event.mediaType}/${event.id}${FiveflixStrings.endpointTrailer}',
    //       fromJson: anyNamed('fromJson'),
    //       keyJson: FiveflixStrings.keyJsonResults,
    //     )).thenThrow(Exception());
    //     return MediaBloc(repository: mockMediaRepository);
    //   },
    //   act: (bloc) => bloc.add(
    //     MediaDetailFetchEvent(),
    //   ),
    //   expect: () => <MediaState>[
    //     MediaLoadingState(),
    //     MediaErrorState(Exception().toString()),
    //   ],
    // );
  });
  //..
}
