import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/blocs/bloc_exports.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Responsive Layout Test |', () {
    setUp(() {});

    Future<void> createWidget(WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: const [],
          child: const MaterialApp(),
        ),
      );

      await tester.pumpAndSettle();
    }

    testWidgets(
      'Verify display of success snackBar when adding an item to favorites',
      (WidgetTester tester) async {},
    );
  });
}
