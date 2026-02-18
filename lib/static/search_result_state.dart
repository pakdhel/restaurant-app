import 'package:restaurant_app/data/model/restaurant.dart';

sealed class SearchResultState {}

class SearchResultNoneState extends SearchResultState {}

class SearchResultLoadingState extends SearchResultState {}

class SearchResultEmptyState extends SearchResultState {}

class SearchResultErrorState extends SearchResultState {
  final String error;
  SearchResultErrorState(this.error);
}

class SearchResultLoadedState extends SearchResultState {
  final List<Restaurant> data;
  SearchResultLoadedState(this.data);
}
