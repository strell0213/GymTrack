import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/entity/exercise.dart';
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
    return await _service.getCount() + 1;
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
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    }
  }

  Future<void> deleteHistory(Exercise exercise) async{
    try{
      _historyService.deleteHistory(exercise);
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
        final isDone = _historyService.hasTodayEntry(historyList, ex.name);
        ex.isDone = isDone;
      }

      notifyListeners();
    } catch(e) {
      _setError(e.toString());
    }
  }

  void reorderExercise(String day, int oldIndex, int newIndex) {
    final list = state.exercises.where((e) => e.day == day).toList();
    if (newIndex > oldIndex) newIndex -= 1;

    final item = list.removeAt(oldIndex);
    list.insert(newIndex, item);

    // Обновляем numPP (порядковый номер)
    for (int i = 0; i < list.length; i++) {
      list[i].numPP = i;
    }

    // Обновляем основное состояние (если хранишь весь список)
    final updatedExercises = state.exercises.map((e) {
      final updated = list.firstWhere((x) => x.numPP == e.numPP, orElse: () => e);
      return e.day == day ? updated : e;
    }).toList();

    _state = _state.copyWith(exercises: updatedExercises);
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