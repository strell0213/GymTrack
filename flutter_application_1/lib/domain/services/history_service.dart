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

  Future<void> saveHistory(List<History> listHistory) async 
  {
    final prefs = await SharedPreferences.getInstance();
    final jsonString =
        jsonEncode(listHistory.map((e) => e.toJson()).toList());
    await prefs.setString(_key, jsonString);
  }

  Future<void> addHistory(Exercise exercise) async 
  {
    final item = History(exercise.name, exercise.weight, exercise.count, DateTime.now().toString());
    final listHistory = await loadHistory();
    listHistory.add(item);
    await saveHistory(listHistory);
  }

  Future<void> deleteHistory(Exercise deleteExercise) async 
  {
    final listHistory = await loadHistory();
    for(int i = 0; i < listHistory.length; i++)
    {
      if(listHistory[i].name == deleteExercise.name && hasTodayEntry(listHistory, deleteExercise.name))
      {
        listHistory.removeAt(i);
        await saveHistory(listHistory);
      } 
    }
  }

  bool hasTodayEntry(List<History> historyList, String exerciseName) {
    final today = DateTime.now();

    return historyList.any((history) {
      if (history.name != exerciseName) return false;

      // Преобразуем строку в DateTime
      final date = history.createAt;

      // Сравниваем по дню, месяцу и году
      return date.year == today.year &&
            date.month == today.month &&
            date.day == today.day;
    });
  }
}