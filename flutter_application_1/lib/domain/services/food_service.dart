import 'dart:convert';

import 'package:flutter_application_1/domain/entity/food.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodService {
  static const _key = 'foods';

  Future<List<Food>> loadExercises() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString == null) return [];

    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((e) => Food.fromJson(e)).toList();
  }

  Future<void> saveExercises(List<Food> exercises) async 
  {
    final prefs = await SharedPreferences.getInstance();
    final jsonString =
        jsonEncode(exercises.map((e) => e.toJson()).toList());
    await prefs.setString(_key, jsonString);
  }
}