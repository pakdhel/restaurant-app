import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

class BodyOfDetailScreen extends StatelessWidget {
  final RestaurantDetail restaurant;

  const BodyOfDetailScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 250,
          pinned: true,
          // backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.5), // warna background
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: Hero(
              tag: restaurant.id,
              child: Image.network(
                restaurant.imageMediumUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        // SliverAppBar(
        //   expandedHeight: 250,
        //   pinned: true,
        //   flexibleSpace: FlexibleSpaceBar(
        //     background: Hero(
        //       tag: restaurant.id,

        //       child: Image.network(
        //         restaurant.imageMediumUrl,
        //         fit: BoxFit.cover,
        //       ),
        //     ),
        //   ),
        // ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(Icons.location_on, size: 18, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        "${restaurant.city}, ${restaurant.address}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.star, size: 18, color: Colors.orange),
                    const SizedBox(width: 4),
                    Text(restaurant.rating.toString()),
                  ],
                ),

                const SizedBox(height: 16),

                Wrap(
                  spacing: 8,
                  children: restaurant.categories
                      .map((category) => Chip(label: Text(category)))
                      .toList(),
                ),

                const SizedBox(height: 24),

                Text(
                  "Description",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(restaurant.description),

                const SizedBox(height: 24),

                Text("Foods", style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                ...restaurant.foods.map(
                  (food) => ListTile(
                    leading: const Icon(Icons.fastfood),
                    title: Text(food),
                  ),
                ),

                const SizedBox(height: 16),

                Text("Drinks", style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                ...restaurant.drinks.map(
                  (drink) => ListTile(
                    leading: const Icon(Icons.local_drink),
                    title: Text(drink),
                  ),
                ),

                const SizedBox(height: 24),
                Text(
                  "Customer Reviews",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),

                ...restaurant.reviews.map(
                  (review) => Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(review.review),
                          const SizedBox(height: 4),
                          Text(
                            review.date,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
