import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/entity/exercise.dart';
import 'package:flutter_application_1/domain/entity/goal.dart';
import 'package:flutter_application_1/domain/services/exercise_service.dart';
import 'package:flutter_application_1/domain/services/history_service.dart';

class ExerciseViewModelState {
  final List<Exercise> exercises;
  final bool isLoading;
  final String? errorMessage;

  ExerciseViewModelState({
    required this.exercises,
    this.isLoading = false,
    this.errorMessage,
  });

  // Копирование состояния с возможностью изменения
  ExerciseViewModelState copyWith({
    List<Exercise>? exercises,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ExerciseViewModelState(
      exercises: exercises ?? this.exercises,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class ExerciseViewModel extends ChangeNotifier {
  final ExerciseService _service;
  final HistoryService _historyService;

  ExerciseViewModel(this._service, this._historyService) {
    loadExercises();
  }

  ExerciseViewModelState _state = ExerciseViewModelState(exercises: []);
  ExerciseViewModelState get state => _state;

  Future<void> loadExercises() async {
    _setLoading(true);
    try {
      final exercises = await _service.loadExercises();
      _state = _state.copyWith(exercises: exercises, isLoading: false);
    } catch (e) {
      _state = _state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
    notifyListeners();
  }

  Future<int> newID() async {
    final exercises = await _service.loadExercises(); // получаем весь список
    if (exercises.isEmpty) return 0;

    final maxId = exercises.map((e) => e.id).reduce((a, b) => a > b ? a : b);
    return maxId + 1;
  }

  Future<void> addExercise(Exercise exercise) async {
    _setLoading(true);
    try {
      await _service.addExercise(exercise);
      await loadExercises(); // Обновляем список
    } catch (e) {
      _setError(e.toString());
    }
  }

  Future<void> updateExercise(Exercise updated) async {
    try {
      updated.checkGoals();
      await _service.updateExercise(updated);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    }
  }

  Future<void> deleteExercise(Exercise deleteExercise) async {
    _setLoading(true);
    try {
      await _service.deleteExercise(deleteExercise);
      await loadExercises();
    } catch (e) {
      _setError(e.toString());
    }
  }

  Future<void> addHistory(Exercise exercise) async{
    try{
      await _historyService.addHistory(exercise);
      await _service.updateExercise(exercise);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    }
  }

  Future<void> deleteHistory(Exercise exercise) async{
    try{
      _historyService.deleteHistory(exercise);
      await _service.updateExercise(exercise);
      notifyListeners();
    } catch(e){
      _setError(e.toString());
    }
  }

  Future<void> checkReadyExersice(List<Exercise> exerciseList) async { 
    try {
      final historyList = await _historyService.loadHistory();
      for(int i = 0; i < exerciseList.length; i++)
      {
        final ex = exerciseList[i];
        final isDone = _historyService.hasTodayEntry(historyList, ex.id);
        ex.isDone = isDone;
        _service.updateExercise(ex);
      }

      notifyListeners();
    } catch(e) {
      _setError(e.toString());
    }
  }

  void reorderExercise(String day, int oldIndex, int newIndex) {
    final dayExercises = state.exercises.where((e) => e.day == day).toList();
    if (newIndex > oldIndex) newIndex -= 1;

    final item = dayExercises.removeAt(oldIndex);
    dayExercises.insert(newIndex, item);

    // Обновляем оригинальный список с новыми позициями
    state.exercises
      ..removeWhere((e) => e.day == day)
      ..addAll(dayExercises);

    _service.saveExercises(state.exercises);

    notifyListeners();
  }


  void _setLoading(bool value) {
    _state = _state.copyWith(isLoading: value, errorMessage: null);
    notifyListeners();
  }

  void _setError(String message) {
    _state = _state.copyWith(errorMessage: message, isLoading: false);
    notifyListeners();
  }
}