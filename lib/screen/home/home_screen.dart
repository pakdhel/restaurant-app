import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/screen/home/restaurant_card_widget.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';
import 'package:restaurant_app/style/error_screen.dart';

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
                      "Selamat Datang",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      "Temukan Restoran Favorit Kamu",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ],
                ),
              ),
            ),

            Consumer<RestaurantListProvider>(
              builder: (context, value, child) {
                return switch (value.resultState) {
                  RestaurantListLoadingState() => SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  RestaurantListLoadedState(data: var restaurantList) =>
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final restaurant = restaurantList[index];
                        return RestaurantCardWidget(
                          key: Key('restaurant_${restaurant.id}'),
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
                  RestaurantListErrorState(error: var message) =>
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: ErrorScreen(
                        onRetry: () {
                          context
                              .read<RestaurantListProvider>()
                              .fetchRestaurantList();
                        },
                      ),
                    ),
                  _ => SliverToBoxAdapter(child: const SizedBox()),
                };
              },
            ),
          ],
        ),
      ),
    );
  }
}
