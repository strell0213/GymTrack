import 'dart:convert';

import 'package:flutter_application_1/domain/entity/goal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoalService {
  static const _key='goal';

  Future<List<Goal>> loadExercises() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString == null) return [];

    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((e) => Goal.fromJson(e)).toList();
  }

  Future<void> saveExercises(List<Goal> exercises) async 
  {
    final prefs = await SharedPreferences.getInstance();
    final jsonString =
        jsonEncode(exercises.map((e) => e.toJson()).toList());
    await prefs.setString(_key, jsonString);
  }

  
}