import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/screen/home/restaurant_card_widget.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      context.read<RestaurantListProvider>().fetchRestaurantList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Restaurant",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      "Recommendation restaurant for you!",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
            ),

            Consumer<RestaurantListProvider>(
              builder: (context, value, child) {
                return switch (value.resultState) {
                  RestaurantListLoadingState() => SliverToBoxAdapter(
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  RestaurantListLoadedState(data: var restaurantList) =>
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final restaurant = restaurantList[index];
                        return RestaurantCardWidget(
                          restaurant: restaurant,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              NavigationRoute.detailRoute.name,
                              arguments: restaurant.id,
                            );
                          },
                        );
                      }, childCount: restaurantList.length),
                    ),
                  RestaurantListErrorState(error: var message) => SliverToBoxAdapter(child: Center(child: Text(message),)),
                  _ => SliverToBoxAdapter(child: const SizedBox())
                };
              },
            ),
          ],
        ),
      ),
    );
  }
}
