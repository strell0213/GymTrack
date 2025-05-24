import 'dart:convert';

import 'package:flutter_application_1/domain/entity/foodsettings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodsettingsService {
  static const _key='foodSettings';

  Future<List<FoodSettings>> loadFoodSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString == null) return [];

    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((e) => FoodSettings.fromJson(e)).toList();
  }

  Future<void> saveFoodSettings(List<FoodSettings> foodSettings) async 
  {
    final prefs = await SharedPreferences.getInstance();
    final jsonString =
        jsonEncode(foodSettings.map((e) => e.toJson()).toList());
    await prefs.setString(_key, jsonString);
  }

  Future<void> checkIfNull() async
  {
    final settings = await loadFoodSettings();
    if(settings.isEmpty)
    {
      settings.add(FoodSettings(0, 0, 0, 0, 0));
      saveFoodSettings(settings);
    }
    else return;
  }
}