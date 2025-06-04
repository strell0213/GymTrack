import 'dart:convert';

import 'package:flutter_application_1/domain/entity/food.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodService {
  static const _key = 'foods';

  Future<List<Food>> loadFoods() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString == null) return [];

    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((e) => Food.fromJson(e)).toList();
  }

  Future<void> saveFoods(List<Food> exercises) async 
  {
    final prefs = await SharedPreferences.getInstance();
    final jsonString =
        jsonEncode(exercises.map((e) => e.toJson()).toList());
    await prefs.setString(_key, jsonString);
  }

   Future<int> newID() async{
    final listFoods = await loadFoods(); // получаем весь список
    if (listFoods.isEmpty) return 0;

    final maxId = listFoods.map((e) => e.idFood).reduce((a, b) => a > b ? a : b);
    return maxId + 1;
  }

  Future<void> updateFood(Food food) async{
    final listFoods = await loadFoods(); // получаем весь список
    for(int i = 0; i < listFoods.length; i++)
    {
      if(listFoods[i].idFood == food.idFood)
      {
        listFoods[i] = food;
      }
    }
    await saveFoods(listFoods);
  }
}