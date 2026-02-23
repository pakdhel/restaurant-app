import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  

  static const String _themeKey = "MY_THEME";

  Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_themeKey) ?? false;
  }

  Future<void> setTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isDark);
  }
}
