import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_browser/app/presentation/widgets/favorite_button.dart';
import 'package:movie_browser/utils/constants.dart';

void main() {
  group('FavoriteButton Widget Test', () {
    testWidgets('Initial state: Correct icon and color',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FavoriteButton(
            isFavorite: false,
            onFavoriteChanged: (bool) {},
          ),
        ),
      );

      final iconFinder = find.byIcon(Icons.favorite);
      expect(iconFinder, findsOneWidget);

      final icon = tester.widget<Icon>(iconFinder);
      expect(icon.color, Colors.white.withValues(alpha: 0.8));
    });

    testWidgets('Tapping changes icon and calls callback',
        (WidgetTester tester) async {
      bool isFavorite = false;
      bool callbackCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return FavoriteButton(
                isFavorite: isFavorite,
                onFavoriteChanged: (newIsFavorite) {
                  setState(() {
                    isFavorite = newIsFavorite;
                    callbackCalled = true;
                  });
                },
              );
            },
          ),
        ),
      );

      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle(); // Wait for the animation to complete

      final iconFinder = find.byIcon(Icons.favorite);
      expect(iconFinder, findsOneWidget);

      final icon = tester.widget<Icon>(iconFinder);
      expect(icon.color, AppConstants.primaryColor.withValues(alpha: 0.8));
      expect(isFavorite, true);
      expect(callbackCalled, true);
    });

    testWidgets('Size is adjustable', (WidgetTester tester) async {
      const double testSize = 40;
      await tester.pumpWidget(
        MaterialApp(
          home: FavoriteButton(
            isFavorite: false,
            onFavoriteChanged: (bool) {},
            size: testSize,
          ),
        ),
      );

      final iconFinder = find.byIcon(Icons.favorite);
      expect(iconFinder, findsOneWidget);

      final icon = tester.widget<Icon>(iconFinder);
      expect(icon.size, testSize);
    });

    testWidgets('Animation works', (WidgetTester tester) async {
      final testKey = const Key('favoriteButton');

      await tester.pumpWidget(
        MaterialApp(
          home: FavoriteButton(
            key: testKey,
            isFavorite: false,
            onFavoriteChanged: (bool) {},
          ),
        ),
      );

      await tester.tap(find.byKey(testKey));
      await tester.pumpAndSettle(); // Wait for the animation to complete

      final scaleTransitionFinder = find.descendant(
        of: find.byKey(testKey),
        matching: find.byType(ScaleTransition),
      );

      expect(scaleTransitionFinder.evaluate().length, 1);
    });
  });
}
