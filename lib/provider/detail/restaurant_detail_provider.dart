import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/static/add_review_result_state.dart';
import 'package:restaurant_app/static/restaurant_detail_result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantDetailProvider(this._apiServices);

  RestaurantDetailResultState _detailResultState = RestaurantDetailNoneState();
  RestaurantDetailResultState get resultState => _detailResultState;

  AddReviewResultState _reviewResultState = AddReviewNoneState();
  AddReviewResultState get reviewResultState => _reviewResultState;

  Future<void> fetchRestaurantDetail(String id) async {
    try {
      _detailResultState = RestaurantDetailLoadingState();
      notifyListeners();
      final result = await _apiServices.getRestaurantDetail(id);

      if (result.error) {
        _detailResultState = RestaurantDetailErrorState(result.message);
        notifyListeners();
      } else {
        _detailResultState = RestaurantDetailLoadedState(result.restaurant);
        notifyListeners();
      }
    } on Exception catch (e) {
      _detailResultState = RestaurantDetailErrorState(e.toString());
      notifyListeners();
    }
  }

  Future<void> addReview(String id, String name, String review) async {
    _reviewResultState = AddReviewLoadingState();
    notifyListeners();

    try {
      final result = await _apiServices.addReview(id, name, review);

      if (result.error) {
        _reviewResultState = AddReviewErrorState(result.message);
        notifyListeners();
      } else {
        final current =
            (_detailResultState as RestaurantDetailLoadedState).data;

        final updatedRestaurant = current.copyWith(
          reviews: result.customerReviews,
        );

        _detailResultState = RestaurantDetailLoadedState(updatedRestaurant);

        _reviewResultState = AddReviewSuccessState();
        notifyListeners();
      }
    } catch (e) {
      _reviewResultState = AddReviewErrorState(e.toString());
      notifyListeners();
    }
  }

  void resetReviewState() {
    _reviewResultState = AddReviewNoneState();
    notifyListeners();
  }
}
