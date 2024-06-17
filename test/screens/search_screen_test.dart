import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/blocs/blocs_exports.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/screens/screens_exports.dart';
import 'package:flutter_fiveflix/screens/search/search_screen.dart';
import 'package:flutter_fiveflix/screens/widgets/widgets_exports.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../mocks/mock_media_bloc.mocks.dart';
import '../mocks/mock_search_bloc.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Search Screen Test |', () {
    late MockSearchBloc searchBloc;
    late MockMediaBloc mediaBloc;
    late MediaModel testMedia;

    setUp(() {
      searchBloc = MockSearchBloc();
      mediaBloc = MockMediaBloc();

      testMedia = MediaModel(
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

      when(searchBloc.state).thenReturn(SearchInitial());
      when(searchBloc.stream)
          .thenAnswer((_) => Stream<SearchState>.fromIterable([]));

      when(mediaBloc.state).thenReturn(MediaInitialState());
      when(mediaBloc.stream)
          .thenAnswer((_) => Stream<MediaState>.fromIterable([]));
    });

    Future<void> createWidget(WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<SearchBloc>.value(
              value: searchBloc,
            ),
            BlocProvider<MediaBloc>.value(
              value: mediaBloc,
            ),
          ],
          child: MaterialApp(
              home: Scaffold(
            appBar: AppBar(
              title: const Text('Search Test'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                      context: tester.element(find.byType(AppBar)),
                      delegate: SearchScreen(),
                    );
                  },
                ),
              ],
            ),
          )),
        ),
      );

      await tester.pumpAndSettle();
    }

    testWidgets(
      'Displays initial state correctly on [search screen]',
      (WidgetTester tester) async {
        when(searchBloc.state).thenReturn(SearchInitial());

        await createWidget(tester);
        await tester.tap(find.byIcon(Icons.search));
        await tester.pumpAndSettle();

        final Finder initialMessage = find.byType(MovieRecomended);
        expect(initialMessage, findsOneWidget);
      },
    );

    testWidgets(
      'Displays loading indicator and search results correctly on [search screen]',
      (WidgetTester tester) async {
        when(searchBloc.stream).thenAnswer(
            (_) => Stream<SearchState>.fromIterable([SearchLoading()]));

        await createWidget(tester);
        await tester.tap(find.byIcon(Icons.search));
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextField), 'Kingdom');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle();

        final Finder mediaItemTextFinder = find.textContaining('Kingdom');
        expect(mediaItemTextFinder, findsWidgets);
        await tester.pumpAndSettle();
      },
    );

    testWidgets(
      'Displays empty message when search returns no results on [search screen]',
      (WidgetTester tester) async {
        when(searchBloc.stream).thenAnswer((_) =>
            Stream<SearchState>.fromIterable(
                [SearchSuccess(searchResult: const [])]));

        await createWidget(tester);
        await tester.tap(find.byIcon(Icons.search));
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextField), 'test query');
        await tester.testTextInput.receiveAction(TextInputAction.search);
        await tester.pumpAndSettle();

        final Finder mediaEmpty = find.byType(CustomEmptyMessageSearch);
        expect(mediaEmpty, findsWidgets);
        await tester.pumpAndSettle();
      },
    );

    testWidgets(
      'Displays filtered search results correctly on [search screen]',
      (WidgetTester tester) async {
        when(searchBloc.stream).thenAnswer(
          (_) => Stream<SearchState>.fromIterable([
            SearchSuccess(searchResult: [testMedia]),
          ]),
        );

        await createWidget(tester);
        await tester.tap(find.byIcon(Icons.search));
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextField), 'Kingdom');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle();

        final Finder mediaItemTextFinder =
            find.text('Kingdom of the Planet of the Apes');
        expect(mediaItemTextFinder, findsOneWidget);
      },
    );

    testWidgets(
      'Clears search field when clear button is pressed on [search screen]',
      (WidgetTester tester) async {
        await createWidget(tester);
        await tester.tap(find.byIcon(Icons.search));
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextField), 'Kingdom');
        await tester.pumpAndSettle();

        final Finder clearButton = find.byIcon(Icons.clear);
        await tester.tap(clearButton);
        await tester.pumpAndSettle();

        final Finder searchField = find.byType(TextField);
        expect((tester.widget(searchField) as TextField).controller!.text,
            isEmpty);
      },
    );
  });
}
