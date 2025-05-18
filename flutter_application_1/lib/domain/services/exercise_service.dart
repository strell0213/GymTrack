import 'dart:convert';

import 'package:flutter_application_1/domain/entity/exercise.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExerciseService {
  static const _key = 'exercises';

  Future<List<Exercise>> loadExercises() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString == null) return [];

    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((e) => Exercise.fromJson(e)).toList();
  }

  Future<void> saveExercises(List<Exercise> exercises) async 
  {
    final prefs = await SharedPreferences.getInstance();
    final jsonString =
        jsonEncode(exercises.map((e) => e.toJson()).toList());
    await prefs.setString(_key, jsonString);
  }

  Future<void> addExercise(Exercise exercise) async 
  {
    final exercises = await loadExercises();
    exercises.add(exercise);
    await saveExercises(exercises);
  }

  Future<void> updateExercise(Exercise updatedExercise) async 
  {
    final exercises = await loadExercises();
    for(int i = 0; i < exercises.length; i++)
    {
      if(exercises[i].id == updatedExercise.id)
      {
        exercises[i] = updatedExercise;
        await saveExercises(exercises);
      } 
    }
  }

  Future<void> deleteExercise(Exercise deleteExercise) async 
  {
    final exercises = await loadExercises();
    for(int i = 0; i < exercises.length; i++)
    {
      if(exercises[i].name == deleteExercise.name)
      {
        exercises.removeAt(i);
        await saveExercises(exercises);
      } 
    }
  }

  Future<Exercise?> getByNumPP(int num) async
  {
    final exercises = await loadExercises();
    for(int i =0; i<exercises.length; i++)
    {
      if(exercises[i].numPP == num) return exercises[i];
    }  
    return null;
  }

  Future<int> MaxNumPP() async
  {
    int curNum=0;
    final exercises = await loadExercises();
    for(int i = 0; i< exercises.length; i++)
    {
      if(exercises[i].numPP > curNum) curNum = exercises[i].numPP;
    }  
    return curNum;
  }

  Future<int> getCount() async{
    final exercises = await loadExercises();
    return exercises.length;
  }

  Future<List<String>?> getTypesStr(int day) async
  {
    String dday = '';
    if(day == 1) dday = 'mon';
    else if(day == 2) dday = 'tue';
    else if(day == 3) dday = 'wed';
    else if(day == 4) dday = 'thu';
    else if(day == 5) dday = 'fri';
    else if(day == 6) dday = 'sat';
    else if(day == 7) dday = 'sun';

    final list = await loadExercises();

    var filter = list.where((e) => e.day == dday).toList();
    List<String> strs = [];
    bool check=false;
    if(filter.isEmpty) return null;

    for(int i = 0; i < filter.length; i++)
    {
      if(strs.isEmpty) strs.add(filter[i].typeExercice);

      for(var str in strs)
      {
        if(str == filter[i].typeExercice) check=true; 
      }

      if (!check) strs.add(filter[i].typeExercice);
      else {
        check = false;
      }
    }

    return strs;
  }
}