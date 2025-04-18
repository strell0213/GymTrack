import 'dart:convert';

import 'package:flutter_application_1/domain/entity/exercise.dart';
import 'package:flutter_application_1/domain/entity/history.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryService {
  static const _key = 'history';

  Future<List<History>> loadHistory() async{
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if(jsonString == null) return [];

    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((e) => History.fromJson(e)).toList();
  }

  Future<void> saveExercises(List<History> listHistory) async 
  {
    final prefs = await SharedPreferences.getInstance();
    final jsonString =
        jsonEncode(listHistory.map((e) => e.toJson()).toList());
    await prefs.setString(_key, jsonString);
  }

  Future<void> addExercise(Exercise exercise) async 
  {
    final item = History(exercise.name, exercise.weight, exercise.count, DateTime.now().toString());
    final listHistory = await loadHistory();
    listHistory.add(item);
    await saveExercises(listHistory);
  }
}