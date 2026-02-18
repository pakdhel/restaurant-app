import 'package:restaurant_app/data/model/customer_review.dart';

class RestaurantDetail {
  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  final List<String> categories;
  final List<String> foods;
  final List<String> drinks;
  final double rating;
  final List<CustomerReview> reviews;

  RestaurantDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.foods,
    required this.drinks,
    required this.rating,
    required this.reviews,
  });

  String get imageMediumUrl =>
      "https://restaurant-api.dicoding.dev/images/medium/$pictureId";

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) {
    return RestaurantDetail(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      city: json['city'],
      address: json['address'],
      pictureId: json['pictureId'],
      categories: (json['categories'] as List)
          .map((e) => e['name'] as String)
          .toList(),
      foods: (json['menus']['foods'] as List)
          .map((e) => e['name'] as String)
          .toList(),
      drinks: (json['menus']['drinks'] as List)
          .map((e) => e['name'] as String)
          .toList(),
      rating: (json['rating'] as num).toDouble(),
      reviews: (json['customerReviews'] as List)
          .map((e) => CustomerReview.fromJson(e))
          .toList(),
    );
  }
}
