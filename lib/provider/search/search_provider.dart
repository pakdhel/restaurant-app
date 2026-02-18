import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/static/search_result_state.dart';

class SearchProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  SearchProvider(this._apiServices);

  SearchResultState _resultState = SearchResultNoneState();
  SearchResultState get resultState => _resultState;

  Future<void> searchRestaurant(String query) async {
    if (query.isEmpty) {
      _resultState = SearchResultNoneState();
      notifyListeners();
      return;
    }

    try {
      _resultState = SearchResultLoadingState();
      notifyListeners();

      final result = await _apiServices.searchRestaurant(query);
      if (result.error) {
        _resultState = SearchResultErrorState('Terjadi kesalahan pada server');
        notifyListeners();
      } else if (result.founded == 0) {
        _resultState = SearchResultEmptyState();
        notifyListeners();
      } else {
        _resultState = SearchResultLoadedState(result.restaurants);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = SearchResultErrorState(e.toString());
      notifyListeners();
    }
  }
}
