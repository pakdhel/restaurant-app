import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/main.dart' as app;

class AppRobot {
  final WidgetTester tester;

  AppRobot(this.tester);

  Future<void> launchApp() async {
    app.main();
    await tester.pumpAndSettle();
  }
}
