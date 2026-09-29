import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ChangeNotifier {
  ThemeController(SharedPreferences prefs)
    : _prefs = prefs,
      _mode = _decode(prefs.getString(storageKey));

  static const storageKey = 'theme_mode';

  final SharedPreferences _prefs;
  ThemeMode _mode;

  ThemeMode get mode => _mode;

  Future<void> setMode(ThemeMode mode) async {
    if (mode == _mode) return;
    _mode = mode;
    notifyListeners();
    await _prefs.setString(storageKey, mode.name);
  }

  Future<void> toggle(Brightness current) {
    return setMode(
      current == Brightness.dark ? ThemeMode.light : ThemeMode.dark,
    );
  }

  static ThemeMode _decode(String? value) {
    return ThemeMode.values.firstWhere(
      (mode) => mode.name == value,
      orElse: () => ThemeMode.system,
    );
  }
}
