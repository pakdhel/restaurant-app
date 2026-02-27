import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/local_database_provider.dart';

class FavoriteButtonWidget extends StatelessWidget {
  final Restaurant restaurant;

  const FavoriteButtonWidget({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalDatabaseProvider>(
      builder: (context, dbProvider, child) {
        final isFavorited = dbProvider.checkItemBookmark(restaurant.id);

        return FloatingActionButton(
          backgroundColor: Colors.grey.withValues(alpha: 0.5),
          shape: const CircleBorder(),
          onPressed: () async {
            if (isFavorited) {
              await dbProvider.removeRestaurantById(restaurant.id);
            } else {
              await dbProvider.saveRestaurant(restaurant);
            }

            await dbProvider.loadAllRestaurant();
          },
          child: Icon(
            isFavorited
                ? Icons.favorite_rounded
                : Icons.favorite_outline_rounded,
          ),
        );
      },
    );
  }
}
