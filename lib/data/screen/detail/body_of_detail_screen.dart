import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/data/screen/detail/review_widget.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/static/add_review_result_state.dart';

class BodyOfDetailScreen extends StatefulWidget {
  final RestaurantDetail restaurant;

  const BodyOfDetailScreen({super.key, required this.restaurant});

  @override
  State<BodyOfDetailScreen> createState() => _BodyOfDetailScreenState();
}

class _BodyOfDetailScreenState extends State<BodyOfDetailScreen> {
  TextEditingController _controllerNama = TextEditingController();
  TextEditingController _controllerReview = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _controllerNama.dispose();
    _controllerReview.dispose();
    super.dispose();
  }

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
              tag: widget.restaurant.id,
              child: Image.network(
                widget.restaurant.imageMediumUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.restaurant.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(Icons.location_on, size: 18, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        "${widget.restaurant.city}, ${widget.restaurant.address}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.star, size: 18, color: Colors.orange),
                    const SizedBox(width: 4),
                    Text(widget.restaurant.rating.toString()),
                  ],
                ),

                const SizedBox(height: 16),

                Wrap(
                  spacing: 8,
                  children: widget.restaurant.categories
                      .map((category) => Chip(label: Text(category)))
                      .toList(),
                ),

                const SizedBox(height: 24),

                Text(
                  "Deskripsi",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(widget.restaurant.description),

                const SizedBox(height: 24),

                Text("Makanan", style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                ...widget.restaurant.foods.map(
                  (food) => ListTile(
                    leading: const Icon(Icons.fastfood),
                    title: Text(food),
                  ),
                ),

                const SizedBox(height: 16),

                Text("Minuman", style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                ...widget.restaurant.drinks.map(
                  (drink) => ListTile(
                    leading: const Icon(Icons.local_drink),
                    title: Text(drink),
                  ),
                ),

                const SizedBox(height: 24),
                Text(
                  "Ulasan Pengunjung",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),

                ...widget.restaurant.reviews.map(
                  (review) => ReviewWidget(customerReview: review),
                ),
                const SizedBox(height: 16),

                Text(
                  'Tulis Ulasan',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _controllerNama,
                  decoration: const InputDecoration(
                    labelText: "Nama",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _controllerReview,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: "Ulasan",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),

                Consumer<RestaurantDetailProvider>(
                  builder: (context, value, child) {
                    final reviewState = value.reviewResultState;

                    if (reviewState is AddReviewLoadingState) {
                      return const CircularProgressIndicator();
                    }

                    if (reviewState is AddReviewSuccessState) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Review berhasil dikirim"),
                          ),
                        );

                        context
                            .read<RestaurantDetailProvider>()
                            .resetReviewState();
                      });
                    }

                    if (reviewState is AddReviewErrorState) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(reviewState.error)),
                        );
                      });
                    }

                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_controllerNama.text.isEmpty ||
                              _controllerReview.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Semua field harus diisi"),
                              ),
                            );
                            return;
                          }
                          context.read<RestaurantDetailProvider>().addReview(
                            widget.restaurant.id,
                            _controllerNama.text,
                            _controllerReview.text,
                          );
                        },
                        child: const Text("Submit Review"),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
