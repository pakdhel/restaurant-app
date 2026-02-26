import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/screen/home/home_screen.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';

class FakeProvider extends ChangeNotifier implements RestaurantListProvider {
  @override
  RestaurantListResultState resultState = RestaurantListLoadingState();

  @override
  Future<void> fetchRestaurantList() async {}
}

void main() {
  testWidgets('menampilkan CircularProgressIndicator saat loading', (
    tester,
  ) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<RestaurantListProvider>(
        create: (_) => FakeProvider(),
        child: const MaterialApp(home: HomeScreen()),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
