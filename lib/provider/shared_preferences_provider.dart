import 'package:flutter/material.dart';
import 'package:restaurant_app/data/shared_preferences_service.dart';
import 'package:workmanager/workmanager.dart';

class SharedPreferencesProvider extends ChangeNotifier {
  final SharedPreferencesService _service;

  SharedPreferencesProvider(this._service) {
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

  Duration _calculateInitialDelay() {
    final now = DateTime.now();
    DateTime scheduleTime = DateTime(now.year, now.month, now.day, 21, 25, 0);

    if (now.isAfter(scheduleTime)) {
      scheduleTime = scheduleTime.add(const Duration(days: 1));
    }

    return scheduleTime.difference(now);
  }

  void toggleDailyReminder(bool value) async {
    _dailyReminder = value;
    await _service.setReminder(value);

    if (value) {
      final initialDelay = _calculateInitialDelay();
      Workmanager().registerPeriodicTask(
        "1",
        "dailyReminderTask",
        initialDelay: initialDelay,
        frequency: const Duration(days: 1),
      );

      Workmanager().registerOneOffTask(
        'test_1',
        'testTask',
        initialDelay: const Duration(seconds: 5),
      );
    } else {
      Workmanager().cancelByUniqueName("1");
      Workmanager().cancelByUniqueName("test_1");
    }
    notifyListeners();
  }

  void _loadSetting() async {
    final isDark = await _service.getTheme();
    final isReminder = await _service.getReminder();

    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    _dailyReminder = isReminder;

    notifyListeners();
  }
}
