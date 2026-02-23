import 'package:flutter/material.dart';
import 'package:restaurant_app/data/local_database_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class LocalDatabaseProvider extends ChangeNotifier {
  final LocalDatabaseService _databaseService;

  LocalDatabaseProvider(this._databaseService);

  List<Restaurant>? _restaurantList;
  List<Restaurant>? get restaurantList => _restaurantList;

  String _message = "";
  String get message => _message;

  Restaurant? _restaurant;
  Restaurant? get restaurant => _restaurant;

  Future<void> loadAllRestaurant() async {
    try {
      _restaurantList = await _databaseService.getAllItems();
      _restaurant = null;
      _message = "berhasil memuat semua data";
      notifyListeners();
    } catch (e) {
      _message = "gagal memuat semua data";
      notifyListeners();
    }
  }

  Future<void> removeRestaurantById(String id) async {
    try {
      await _databaseService.removeItem(id);
      _message = "berhasil menghapus data";
      notifyListeners();
    } catch (e) {
      _message = "gagal menghapus data";
      notifyListeners();
    }
  }

  Future<void> saveRestaurant(Restaurant restaurant) async {
    try {
      final result = await _databaseService.insertItem(restaurant);
      final isError = result == 0;
      if (isError) {
        _message = "gagal menyimpan data";
      } else {
        _message = "berhasil menyimpan data";
      }
      print(_message);
      notifyListeners();
    } catch (e) {
      _message = "gagal menyimpan data";
      notifyListeners();
    }
  }

  bool checkItemBookmark(String id) {
    return _restaurantList?.any((restaurant) => restaurant.id == id) ?? false;
  }
}
