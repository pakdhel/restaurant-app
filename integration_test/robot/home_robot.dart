import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/screen/home/restaurant_card_widget.dart';

class HomeRobot {
  final WidgetTester tester;

  HomeRobot(this.tester);

  Future<void> tapRestaurantById(String id) async {
    await tester.tap(find.byKey(Key('restaurant_$id')));
    await tester.pumpAndSettle();
  }

  void expectRestaurantListLoaded() {
    expect(find.byType(RestaurantCardWidget), findsWidgets);
  }
}
