import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'robot/app_robot.dart';
import 'robot/detail_robot.dart';
import 'robot/home_robot.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('User bisa memilih restaurant favorite ', (
    WidgetTester tester,
  ) async {
    final appRobot = AppRobot(tester);
    final homeRobot = HomeRobot(tester);
    final detailRobot = DetailRobot(tester);

    await appRobot.launchApp();

    homeRobot.expectRestaurantListLoaded();

    const testRestaurantId = 'rqdv5juczeskfw1e867';

    await homeRobot.tapRestaurantById(testRestaurantId);

    detailRobot.expectDetailScreen();

    await detailRobot.tapFavoriteButton();

    detailRobot.expectFavorited();
  });
}
