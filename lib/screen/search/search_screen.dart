import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/screen/home/restaurant_card_widget.dart';
import 'package:restaurant_app/provider/search/search_provider.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/static/search_result_state.dart';
import 'package:restaurant_app/style/error_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

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
                      "Cari Restoran",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      "Ketik untuk mulai mencari restoran",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Ketik nama, kategori, atau menu",
                        hintStyle: Theme.of(context).textTheme.titleSmall,
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: (value) {
                        context.read<SearchProvider>().searchRestaurant(value);
                      },
                    ),
                  ],
                ),
              ),
            ),

            Consumer<SearchProvider>(
              builder: (context, value, child) {
                return switch (value.resultState) {
                  SearchResultLoadingState() => SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  SearchResultErrorState(error: var _) =>
                    // SliverToBoxAdapter(
                    //   child:
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: ErrorScreen(onRetry: () {}),
                    ),
                  // ),
                  SearchResultEmptyState() => SliverToBoxAdapter(
                    child: Center(child: Text('Restoran tidak ditemukan')),
                  ),
                  SearchResultNoneState() => SliverToBoxAdapter(
                    child: Center(child: Text('Silakan cari restorant')),
                  ),
                  SearchResultLoadedState(data: var restaurants) => SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final restaurant = restaurants[index];
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
                    }, childCount: restaurants.length),
                  ),
                };
              },
            ),
          ],
        ),
      ),
    );
  }
}
