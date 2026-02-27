import 'package:flutter/material.dart';
import 'package:restaurant_app/style/colors/restaurant_colors.dart';
import 'package:restaurant_app/style/typography/restaurant_text_styles.dart';

class RestaurantTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorSchemeSeed: RestaurantColors.green.color,
      brightness: Brightness.light,
      textTheme: _textTheme,
      useMaterial3: true,
      elevatedButtonTheme: _elevatedButtonTheme,
      inputDecorationTheme: _inputDecorationTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorSchemeSeed: RestaurantColors.green.color,
      brightness: Brightness.dark,
      textTheme: _textTheme,
      useMaterial3: true,
    );
  }

  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: RestaurantTextStyles.displayLarge,
      displayMedium: RestaurantTextStyles.displayMedium,
      displaySmall: RestaurantTextStyles.displaySmall,
      headlineLarge: RestaurantTextStyles.headlineLarge,
      headlineMedium: RestaurantTextStyles.headlineMedium,
      headlineSmall: RestaurantTextStyles.headlineSmall,
      titleLarge: RestaurantTextStyles.titleLarge,
      titleMedium: RestaurantTextStyles.titleMedium,
      titleSmall: RestaurantTextStyles.titleSmall,
      bodyLarge: RestaurantTextStyles.bodyLargeBold,
      bodyMedium: RestaurantTextStyles.bodyLargeMedium,
      bodySmall: RestaurantTextStyles.bodyLargeRegular,
      labelLarge: RestaurantTextStyles.labelLarge,
      labelMedium: RestaurantTextStyles.labelMedium,
      labelSmall: RestaurantTextStyles.labelSmall,
    );
  }

  static InputDecorationTheme get _inputDecorationTheme {
    return InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade100,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: RestaurantColors.green.color, width: 2),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red),
      ),

      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  static ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: RestaurantColors.green.color,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  static OutlinedButtonThemeData get _outlinedButtonTheme {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: RestaurantColors.green.color,
        side: BorderSide(color: RestaurantColors.green.color),
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
