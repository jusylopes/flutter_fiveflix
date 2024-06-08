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
        GameModel(nameGame: 'nameGame', posterPath: 'posterPath', questions: [
          Question(options: [], text: 'text'),
        ])
      ];
    });


   // caminho feliz =] GameFethEvent
    blocTest<GameBloc, GameState>(
      'emits [GameLoadingState, GameErrorState] when GameFetchEvent is added and fetch fails.',
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
