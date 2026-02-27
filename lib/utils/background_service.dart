import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/local_notification_service.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (kDebugMode) {
      print("Native called background task: $task");
    }

    try {
      final apiService = ApiServices();
      final restaurantResult = await apiService.getRestaurantList();
      final restaurants = restaurantResult.restaurants;

      if (restaurants.isNotEmpty) {
        final random = Random();
        final randomIndex = random.nextInt(restaurants.length);
        final randomRestaurant = restaurants[randomIndex];

        final notificationService = LocalNotificationService();
        await notificationService.init();

        await notificationService.showNotification(
          id: 1,
          title: "🍽️ Yuk, Waktunya Makan Siang!",
          body: "Cobain makan di ${randomRestaurant.name}, letaknya di ${randomRestaurant.city} loh!",
          payload: randomRestaurant.id,
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching random restaurant: $e");
      }
      return Future.value(false);
    }

    return Future.value(true);
  });
}
