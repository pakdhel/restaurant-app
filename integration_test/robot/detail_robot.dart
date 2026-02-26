import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class DetailRobot {
  final WidgetTester tester;
  DetailRobot(this.tester);

  void expectDetailScreen() {
    expect(find.byType(FloatingActionButton), findsOneWidget);
  }

  Future<void> tapFavoriteButton() async {
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
  }

  void expectFavorited() {
    expect(find.byIcon(Icons.favorite_rounded), findsOneWidget);
  }
}
