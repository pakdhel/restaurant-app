import 'package:flutter/material.dart';
import 'package:restaurant_app/data/local_notification_service.dart';
import 'package:restaurant_app/data/shared_preferences_service.dart';

class SharedPreferencesProvider extends ChangeNotifier {
  final SharedPreferencesService _service;
  final LocalNotificationService _notificationService;

  SharedPreferencesProvider(this._service, this._notificationService) {
    _loadSetting();
  }

  ThemeMode _themeMode = ThemeMode.light;
  bool _dailyReminder = false;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;
  bool get isDailyReminderOn => _dailyReminder;

  void toggleTheme(bool isDark) async {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    await _service.setTheme(isDark);
    notifyListeners();
  }

  void toggleDailyReminder(bool value) async {
    _dailyReminder = value;
    await _service.setReminder(value);

    if (value) {
      await _notificationService.scheduleDailyElevenAMNotification(id: 1);
    } else {
      await _notificationService.cancelNotification(1);
    }
    notifyListeners();
  }

  void _loadSetting() async {
    final isDark = await _service.getTheme();
    final isReminder = await _service.getReminder();

    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    _dailyReminder = isReminder;

    if (isReminder) {
      await _notificationService.scheduleDailyElevenAMNotification(id: 1);
    }
    notifyListeners();
  }
}
