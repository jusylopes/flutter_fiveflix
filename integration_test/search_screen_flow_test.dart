import 'dart:async';

import 'package:flutter/material.dart';
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

  group('Search Screen Flow Test |', () {
    final Finder searchDelegateOnPressed = find.byKey(const ValueKey('search'));
    const String searchQuery = 'harry';
    final Finder mediaItemTile =
        find.byKey(const ValueKey('media_tile_search'));

    Future<void> delay(int timeSec) async {
      await Future.delayed(Duration(seconds: timeSec));
    }

    Future<void> enterSearchQuery(WidgetTester tester, String query) async {
      await tester.enterText(find.byType(TextField), query);
      await delay(2); 
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
    }

    testWidgets('Verify search screen components', (WidgetTester tester) async {
      await tester.pumpWidget(const app.MyApp());
      await tester.pumpAndSettle();

      await tester.tap(searchDelegateOnPressed);
      await tester.pumpAndSettle();

      await enterSearchQuery(tester, searchQuery);

      final Finder mediaItemTextFinder = find.textContaining(searchQuery);
      expect(mediaItemTextFinder, findsWidgets);

      final Finder scrollableFinderMedia = find.byType(ListView);
      await tester.drag(scrollableFinderMedia, const Offset(0, -300));
      await tester.pumpAndSettle();
      expect(mediaItemTile, findsWidgets);

      await tester.tap(mediaItemTile.first);
      await tester.pumpAndSettle();

      // final Completer<void> completer = Completer<void>();
      // await tester.pumpAndSettle();
      // await completer.future; // apenas p apresentaçao

    });
  });
}