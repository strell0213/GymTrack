import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/entity/exercise.dart';
import 'package:flutter_application_1/domain/services/exercise_service.dart';

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

  ExerciseViewModel(this._service) {
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
    _setLoading(true);
    try {
      await _service.updateExercise(updated);
      await loadExercises();
    } catch (e) {
      _setError(e.toString());
    }
  }

  Future<void> deleteExercise(int index) async {
    _setLoading(true);
    try {
      await _service.deleteExercise(index);
      await loadExercises();
    } catch (e) {
      _setError(e.toString());
    }
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