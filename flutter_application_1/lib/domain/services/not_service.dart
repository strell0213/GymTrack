import 'dart:async';
import 'dart:convert';

import 'package:flutter_application_1/domain/entity/notify.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotService 
{
  static const _key='not';

  Future<List<Not>> loadNot() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString == null) return [];

    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((e) => Not.fromJson(e)).toList();
  }

  Future<void> saveNot(List<Not> exercises) async 
  {
    final prefs = await SharedPreferences.getInstance();
    final jsonString =
        jsonEncode(exercises.map((e) => e.toJson()).toList());
    await prefs.setString(_key, jsonString);
  }

  Future<void> deleteAllNot() async
  {
    final list = await loadNot();
    for(int i = 0; i< list.length; i++)
    {
      list.removeAt(i);
    }
    saveNot(list);
  }

  Future<void> deleteOldNot() async {
    final list = await loadNot();

    final now = DateTime.now();

    // Оставляем только те, у которых дата >= сегодня
    final updatedList = list.where((not) {
      final notDate = DateTime.tryParse(not.date);
      return notDate != null && notDate.isAfter(now);
    }).toList();

    await saveNot(updatedList);
  }

  Future<void> addNot(Not not) async
  {
    final list = await loadNot();
    list.add(not);
    saveNot(list);
  }

  Future<int> newID() async
  {
    final listNot = await loadNot(); // получаем весь список
    if (listNot.isEmpty) return 0;

    final maxId = listNot.map((e) => e.id).reduce((a, b) => a > b ? a : b);
    return maxId + 1; 
  }

  Future<bool> checkNot(Not not) async
  {
    final listNot = await loadNot(); // получаем весь список
    if(listNot.isEmpty) return true;

    for(int i =0; i< listNot.length; i++)
    {
      if (listNot[i].type != not.type) continue;

      DateTime date1 = DateTime.parse(listNot[i].date);
      DateTime date2 = DateTime.parse(not.date);
      if (date1.year == date2.year) {
        if(date1.month == date2.month) {
          if(date1.day == date2.day) {
            return false;
          }
        }
      }
    }

    return true;
  }
}