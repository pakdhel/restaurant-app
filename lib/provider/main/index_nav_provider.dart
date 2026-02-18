import 'package:flutter/material.dart';

class IndexNavProvider extends ChangeNotifier {
  int _indexBottomNav = 0;
  int get indexBottomNav => _indexBottomNav;

  set setIndexBottomNav(int value) {
    _indexBottomNav = value;
    notifyListeners();
  }
}
