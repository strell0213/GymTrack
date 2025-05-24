import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeViewModel extends ChangeNotifier {
  static const _themeKey = 'isDarkTheme';
  static const _weightKey = 'weight';
  static const _tallKey = 'tall';
  static const _oneProteinKey = 'oneProtein';
  static const _oneFatsKey = 'oneFats';
  static const _oneCarKey = 'oneCar'; 

  bool _isDarkTheme = false;
  double _weight = 0;
  double _tall = 0;
  double _oneProtein=0;
  double _oneFats = 0;
  double _oneCar = 0;

  bool get isDarkTheme => _isDarkTheme;
  double get weight => _weight;
  double get tall => _tall;
  double get oneProtein => _oneProtein;
  double get oneFats => _oneFats;
  double get oneCar => _oneCar;

  ThemeMode get currentThemeMode => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  ThemeViewModel() {
    _loadTheme();
  }

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    _saveTheme();
    notifyListeners();
  }

  void load()
  {
    _loadTheme();
    notifyListeners();
  }

  void saveFoods(double weightC, double tallC, double onePC, double oneFC, double oneCC)
  {
    _weight = weightC;
    _tall = tallC;
    _oneProtein = onePC;
    _oneFats = oneFC;
    _oneCar = oneCC;
    _saveTheme();
    notifyListeners();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkTheme = prefs.getBool(_themeKey) ?? false;
    _weight = prefs.getDouble(_weightKey) ?? 0;
    _tall = prefs.getDouble(_tallKey) ?? 0;
    _oneProtein = prefs.getDouble(_oneProteinKey) ?? 0;
    _oneFats = prefs.getDouble(_oneFatsKey) ?? 0;
    _oneCar = prefs.getDouble(_oneCarKey) ?? 0;
    notifyListeners();
  }

  Future<void> _saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, _isDarkTheme);
    await prefs.setDouble(_weightKey, _weight);
    await prefs.setDouble(_tallKey, _tall);
    await prefs.setDouble(_oneProteinKey, _oneProtein);
    await prefs.setDouble(_oneFatsKey, _oneFats);
    await prefs.setDouble(_oneCarKey, _oneCar);
  }
}
