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
      if(exercises[i].name == updatedExercise.name)
      {
        exercises[i] = updatedExercise;
        await saveExercises(exercises);
      } 
    }
    // if (index >= 0 && index < exercises.length) 
    // {
    //   exercises[index] = updatedExercise;
    //   await saveExercises(exercises);
    // }
  }

  Future<void> deleteExercise(int index) async 
  {
    final exercises = await loadExercises();
    if (index >= 0 && index < exercises.length) 
    {
      exercises.removeAt(index);
      await saveExercises(exercises);
    }
  }
}