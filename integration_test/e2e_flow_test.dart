import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/widgets_keys.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_fiveflix/main.dart' as app;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  setUpAll(() async {
    await HiveConfig.start();
  });

  tearDownAll(() async {
    await Hive.close();
  });

  group('E2E Flow Test |', () {
    const String searchQuery = 'Lord of';

    Future<void> enterSearchQuery(WidgetTester tester, String query) async {
      await tester.enterText(find.byType(TextField), query);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle(const Duration(seconds: 1));
    }

    int getBadgeCount(WidgetTester tester) {
      final badgeText = tester.widget<Text>(
        find.byKey(ValueKey(WidgetKeys.favoriteCountBadge.key)),
      );
      return int.parse(badgeText.data!);
    }

    Future<void> searchItem(WidgetTester tester) async {
      final Finder searchIcon = find.byKey(ValueKey(WidgetKeys.searchIcon.key));
      await tester.tap(searchIcon);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await enterSearchQuery(tester, searchQuery);
      final Finder mediaItemTextFinder = find.textContaining(searchQuery);
      expect(mediaItemTextFinder, findsWidgets);
      await tester.pumpAndSettle(const Duration(seconds: 5));
    }

    Future<void> favoriteItem(WidgetTester tester) async {
      final Finder favoriteButton =
          find.byKey(ValueKey(WidgetKeys.favoriteButton.key));
      expect(find.byIcon(Icons.add), findsOneWidget);
      await tester.tap(favoriteButton);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text(FiveflixStrings.addItemFavoriteSucess), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.byIcon(Icons.check), findsOneWidget);
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle(const Duration(seconds: 2));
    }

    Future<void> navigateToSectionAndVerifyCard(
        WidgetTester tester, String sectionKey, String cardKey) async {
      final Finder sectionIcon = find.byKey(ValueKey(sectionKey));
      await tester.tap(sectionIcon);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      final Finder sectionCard = find.byKey(ValueKey(cardKey));
      expect(sectionCard, findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 2));
    }

    Future<void> removeFavorite(
        WidgetTester tester, int initialBadgeCount) async {
      final Finder favoritesIcon =
          find.byKey(ValueKey(WidgetKeys.favoritesScreenIcon.key));
      await tester.tap(favoritesIcon);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      final Finder removeFavoriteIcon = find.byIcon(Icons.remove);
      await tester.tap(removeFavoriteIcon);
      await tester.pumpAndSettle(const Duration(seconds: 6));
    }

    testWidgets('Search query and favorite item Flow Test',
        (WidgetTester tester) async {
      await tester.pumpWidget(const app.MyApp());
      await tester.pumpAndSettle(const Duration(seconds: 4));

      int initialBadgeCount = getBadgeCount(tester);

      await searchItem(tester);

      final Finder firstSearchResultTile =
          find.byKey(ValueKey(WidgetKeys.searchTile.key));
      expect(firstSearchResultTile, findsWidgets);
      await tester.tap(firstSearchResultTile.first);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      await favoriteItem(tester);

      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      expect(getBadgeCount(tester), equals(initialBadgeCount + 1));

      await navigateToSectionAndVerifyCard(
          tester, WidgetKeys.gamesScreenIcon.key, WidgetKeys.gamesCard.key);

      await navigateToSectionAndVerifyCard(
          tester, WidgetKeys.newsScreenIcon.key, WidgetKeys.newsCard.key);

      await removeFavorite(tester, initialBadgeCount);

      final Finder confimDialog = find.byType(AlertDialog);
      expect(confimDialog, findsOneWidget);
      await tester.tap(find.byKey(ValueKey(WidgetKeys.favoriteRemoveIcon.key)));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      final textEmptyFavorite = find.text(FiveflixStrings.emptyMessageFavorite);
      expect(textEmptyFavorite, findsOneWidget);

      expect(getBadgeCount(tester), equals(initialBadgeCount));

      // apenas para apresentação
      await Future.delayed(const Duration(seconds: 10));
    });
  });
}
