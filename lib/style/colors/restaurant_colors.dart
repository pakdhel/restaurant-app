import 'package:flutter/material.dart';

enum RestaurantColors {
  green("Green", Colors.green);

  const RestaurantColors(this.name, this.color);

  final String name;
  final Color color;
}
