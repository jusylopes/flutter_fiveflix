import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_fiveflix/blocs/bloc_exports.dart';
import 'package:flutter_fiveflix/repositories/game_repository.dart';
import 'package:flutter_fiveflix/screens/game/game_model.dart';
import 'package:flutter_fiveflix/utils/fiveflix_strings.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'game_bloc_test.mocks.dart';

@GenerateMocks([GameRepository])
void main() {
  group('Game Bloc Tests |', () {
    late MockGameRepository mockRepository;
    late List<GameModel> games;

    setUp(() {
      mockRepository = MockGameRepository();

      games = [
        GameModel(
            nameGame: 'Guess the movie by emoji: Easy 😁',
            posterPath: 'posterPath',
            questions: [
              Question(
                options: [
                  Option(isCorrect: false, text: 'Toy Story'),
                  Option(isCorrect: false, text: 'Up'),
                  Option(isCorrect: true, text: 'Inside Out'),
                ],
                text: '😁😡😭😱',
              ),
            ])
      ];
    });

    ///////////////////////////////////////////////////[GameFetchEvent] TESTS
    blocTest<GameBloc, GameState>(
      'emits [GameLoadingState, GameSuccesstate] when GameFetchEvent is added and fetch fails.',
      build: () {
        when(mockRepository.getListGame(
          endpoint: FiveflixStrings.baseUrlApiGames,
          fromJson: anyNamed('fromJson'),
        )).thenAnswer((_) async => games);
        return GameBloc(repository: mockRepository);
      },
      act: (bloc) => bloc.add(GameFetchEvent()),
      expect: () => <GameState>[
        GameLoadingState(),
        GameSuccessState(games: games),
      ],
    );

    blocTest<GameBloc, GameState>(
      'emits [GameLoadingState, GameErrorState] when GameFetchEvent is added and fetch fails',
      build: () {
        when(mockRepository.getListGame(
          endpoint: FiveflixStrings.baseUrlApiGames,
          fromJson: anyNamed('fromJson'),
        )).thenThrow(Exception());
        return GameBloc(repository: mockRepository);
      },
      act: (bloc) => bloc.add(GameFetchEvent()),
      expect: () => <GameState>[
        GameLoadingState(),
        GameErrorState(Exception().toString()),
      ],
    );
  });
}
