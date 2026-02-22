import 'package:flutter/material.dart';
import 'package:restaurant_app/data/local_database_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class LocalDatabaseProvider extends ChangeNotifier {
  final LocalDatabaseService _databaseService;

  LocalDatabaseProvider(this._databaseService);

  List<Restaurant>? _restaurantList;
  List<Restaurant>? get restaurantList => _restaurantList;

  String _message = "";
  String get message => message;

  Future<void> loadAllRestaurant() async {
    try {
      _restaurantList = await _databaseService.getAllItems();
      _message = "berhasil memuat semua data";
      notifyListeners();
    } catch (e) {
      _message = "gagal memuat semua data";
      notifyListeners();
    }
  }
}
