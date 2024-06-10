import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/blocs/bloc_exports.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/screens/media_detail/widgets/media_detail_widgets_exports.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'favorite_button_test.mocks.dart';

@GenerateMocks([FavoriteBloc])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Favorite Widget Tests |', () {
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

      when(favoriteBloc.state)
          .thenReturn(FavoriteGetAllSuccessState(items: const []));
    });

    Future<void> createWidget(WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<FavoriteBloc>.value(
              value: favoriteBloc,
            ),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: FavoriteButton(itemFavorite: testMedia),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
    }

    testWidgets(
      'Verify display of success snackBar when adding an item to favorites',
      (WidgetTester tester) async {
        when(favoriteBloc.stream)
            .thenAnswer((_) => Stream<FavoriteState>.fromIterable([
                  FavoriteGetAllSuccessState(items: const []),
                  FavoriteItemAddedState(item: testMedia),
                ]));
        await createWidget(tester);
        expect(
            find.text(FiveflixStrings.addItemFavoriteSucess), findsOneWidget);
      },
    );

    testWidgets(
      'Verify display of success snackBar when remove an item to favorites',
      (WidgetTester tester) async {
        when(favoriteBloc.stream)
            .thenAnswer((_) => Stream<FavoriteState>.fromIterable([
                  FavoriteGetAllSuccessState(items: const []),
                  FavoriteItemRemovedState(),
                ]));
        await createWidget(tester);
        expect(find.text(FiveflixStrings.removeItemFavoriteSucess),
            findsOneWidget);
      },
    );

    testWidgets(
      'Verify display of icon check when adding an item to favorites success',
      (WidgetTester tester) async {
        when(favoriteBloc.stream)
            .thenAnswer((_) => Stream<FavoriteState>.fromIterable([
                  FavoriteGetAllSuccessState(items: [testMedia]),
                ]));
        await createWidget(tester);
        expect(find.byIcon(Icons.check), findsOneWidget);
      },
    );

    testWidgets(
      'Verify display of icon add when remove an item to favorites success',
      (WidgetTester tester) async {
        when(favoriteBloc.stream).thenAnswer((_) =>
            Stream<FavoriteState>.fromIterable([FavoriteItemRemovedState()]));
        await createWidget(tester);
        expect(find.byIcon(Icons.add), findsOneWidget);
      },
    );
  });
}
