import 'package:flutter/material.dart';

class FavoriteButtonProvider extends ChangeNotifier {
  bool _isFavorites = false;

  bool get isFavorite => _isFavorites;

  set isFavorited(bool value) {
    _isFavorites = value;
    notifyListeners();
  }
}
