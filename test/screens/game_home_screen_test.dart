import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/blocs/blocs_exports.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/screens/game/game_model.dart';
import 'package:flutter_fiveflix/screens/screens_exports.dart';
import 'package:flutter_fiveflix/screens/widgets/widgets_exports.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../mocks/mock_game_bloc.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Game Home Screen Test |', () {
    late MockGameBloc gameBloc;
    late List<GameModel> games;

    setUp(() {
      gameBloc = MockGameBloc();

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

      when(gameBloc.state).thenReturn(GameInitialState());
    });

    Future<void> createWidget(WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<GameBloc>.value(
              value: gameBloc,
            ),
          ],
          child: const MaterialApp(home: GameHomeScreen()),
        ),
      );

      await tester.pumpAndSettle();
    }

    testWidgets(
      'Verify [loading] state display on [game home screen]',
      (WidgetTester tester) async {
        when(gameBloc.stream).thenAnswer(
            (_) => Stream<GameState>.fromIterable([GameLoadingState()]));

        await createWidget(tester);

        expect(find.byKey(ValueKey(WidgetKeys.fiveflixLoading.key)),
            findsOneWidget);
      },
    );

    testWidgets(
      'Verify [sucsess] state display on [game home screen]',
      (WidgetTester tester) async {
        when(gameBloc.stream).thenAnswer(
          (_) => Stream<GameState>.fromIterable(
            [GameLoadingState(), GameSuccessState(games: games)],
          ),
        );

        await createWidget(tester);

        final Finder gameCard = find.byKey(ValueKey(WidgetKeys.gamesCard.key));
        expect(gameCard, findsOneWidget);
        await tester.tap(gameCard.first);

        await tester.pumpAndSettle();

        final textTitleGame = find.text('Guess the movie by emoji: Easy 😁');
        expect(textTitleGame, findsOneWidget);
      },
    );

    testWidgets(
      'Verify [error] state display on [game home screen]',
      (WidgetTester tester) async {
        when(gameBloc.stream).thenAnswer(
          (_) => Stream<GameState>.fromIterable(
            [
              GameLoadingState(),
              GameErrorState(
                Exception().toString(),
              ),
            ],
          ),
        );

        await createWidget(tester);

        expect(
            find.byWidgetPredicate(
              (widget) =>
                  widget is ErrorLoadingMessage &&
                  widget.errorMessage == Exception().toString(),
            ),
            findsOneWidget);
      },
    );
  });
}
