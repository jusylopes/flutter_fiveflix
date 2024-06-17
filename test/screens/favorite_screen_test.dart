import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/blocs/blocs_exports.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/screens/screens_exports.dart';
import 'package:flutter_fiveflix/screens/widgets/widgets_exports.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../mocks/mock_favorite_bloc.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Favorite Screen Test |', () {
    late MockFavoriteBloc favoriteBloc;
    late MediaModel testMedia;

    setUp(() {
      favoriteBloc = MockFavoriteBloc();

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

      when(favoriteBloc.state).thenReturn(FavoriteInitialState());
    });

    Future<void> createWidget(WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<FavoriteBloc>.value(
              value: favoriteBloc,
            ),
          ],
          child: const MaterialApp(home: FavoriteScreen()),
        ),
      );

      await tester.pumpAndSettle();
    }

    testWidgets(
      'Verify [loading] state display on [favorite screen]',
      (WidgetTester tester) async {
        when(favoriteBloc.stream).thenAnswer((_) =>
            Stream<FavoriteState>.fromIterable([FavoriteLoadingState()]));

        await createWidget(tester);

        expect(find.byKey(ValueKey(WidgetKeys.fiveflixLoading.key)),
            findsOneWidget);
      },
    );

    testWidgets(
      'Verify [sucsess] state display on [favorite screen]',
      (WidgetTester tester) async {
        when(favoriteBloc.stream).thenAnswer(
          (_) => Stream<FavoriteState>.fromIterable(
            [
              FavoriteLoadingState(),
              FavoriteGetAllSuccessState(items: [testMedia])
            ],
          ),
        );

        await createWidget(tester);

        final Finder favoriteCard =
            find.byKey(ValueKey(WidgetKeys.favoritesCard.key));
        expect(favoriteCard, findsOneWidget);
        await tester.tap(favoriteCard.first);

        await tester.pumpAndSettle();

        final textTitleMedia = find.text('Kingdom of the Planet of the Apes');
        expect(textTitleMedia, findsOneWidget);
      },
    );

    testWidgets(
      'Verify [error] state display on [favorite screen]',
      (WidgetTester tester) async {
        when(favoriteBloc.stream).thenAnswer(
          (_) => Stream<FavoriteState>.fromIterable(
            [
              FavoriteLoadingState(),
              FavoriteErrorState(
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
