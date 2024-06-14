import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/widgets_keys.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_fiveflix/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await HiveConfig.start();
  });

  tearDownAll(() async {
    await Hive.close();
  });

  group('Favorite Item Flow Test |', () {
    Future<void> delay(int timeSec) async {
      await Future.delayed(Duration(seconds: timeSec));
    }

    testWidgets('Verify favorite flow components', (WidgetTester tester) async {
      await tester.pumpWidget(const app.MyApp());
      await tester.pumpAndSettle();

      final Finder tabPopularMovies =
          find.byKey(ValueKey(WidgetKeys.tabPopularMovies.key));
      await tester.tap(tabPopularMovies);
      await tester.pumpAndSettle();
      await delay(2);

      final Finder popularScreen =
          find.byKey(ValueKey(WidgetKeys.popularMovieScreen.key));
      expect(popularScreen, findsOneWidget);
      final Finder cardMovies = find.byKey(ValueKey(WidgetKeys.cardMovies.key));
      await tester.tap(cardMovies.first);
      await tester.pumpAndSettle();
      await delay(2);

      final Finder favoriteButton =
          find.byKey(ValueKey(WidgetKeys.favoriteButton.key));
      await tester.tap(favoriteButton);
      await tester.pumpAndSettle();
      await delay(2);

      expect(find.text(FiveflixStrings.addItemFavoriteSucess), findsOneWidget);
      await tester.pumpAndSettle();
      await delay(2);

      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
      await delay(2);

      final Finder iconGames = find.byKey(ValueKey(WidgetKeys.iconGames.key));
      await tester.tap(iconGames);
      await tester.pumpAndSettle();

      final Finder cardGames = find.byKey(ValueKey(WidgetKeys.cardGames.key));
      expect(cardGames, findsOneWidget);
      await tester.pumpAndSettle();
      await delay(2);

      final Finder iconNews = find.byKey(ValueKey(WidgetKeys.iconNews.key));
      await tester.tap(iconNews);
      await tester.pumpAndSettle();

      final Finder cardNewsMovies =
          find.byKey(ValueKey(WidgetKeys.cardNewsMovies.key));
      expect(cardNewsMovies, findsOneWidget);
      await tester.pumpAndSettle();
      await delay(2);

      final Finder iconFavorites =
          find.byKey(ValueKey(WidgetKeys.iconFavorites.key));
      await tester.tap(iconFavorites);
      await tester.pumpAndSettle();

      final Finder cardFavorites =
          find.byKey(ValueKey(WidgetKeys.cardFavorites.key));
      expect(cardFavorites, findsOneWidget);
      await tester.pumpAndSettle();
      await delay(2);

      // apenas para apresentação
      // final Completer<void> completer = Completer<void>();
      // await tester.pumpAndSettle();
      // await completer.future;
    });
  });
}
