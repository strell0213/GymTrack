import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/entity/exercise.dart';
import 'package:flutter_application_1/domain/entity/goal.dart';

class GoalState{
  final Exercise exercise;
  final bool isLoading;
  final String? errorMessage;

  GoalState({
    required this.exercise,
    this.isLoading=false,
    this.errorMessage,
  });

  GoalState copyWith({
    Exercise? exercise,
    bool? isLoading,
    String? errorMessage,
  }) {
    return GoalState(
      exercise: exercise ?? this.exercise,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class GoalViewModal extends ChangeNotifier{
  final Exercise exercise;

  late GoalState _state;

  GoalViewModal(this.exercise) {
    _state = GoalState(exercise: exercise);
  }
  GoalState get state => _state;

  Future<void> getGoalList() async {
    _setLoading(true);
    try{
      _state.copyWith(exercise: exercise, isLoading: false);
    } catch (e) {
      _state = _state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
    notifyListeners();
  }

  void _setLoading(bool value) {
    _state = _state.copyWith(isLoading: value, errorMessage: null);
    notifyListeners();
  }

  Future<void> deleteGoal(Goal goal) async{
    final goals = exercise.goals;
    for(int i = 0; i < goals.length; i++)
    {
      if(goals[i].idGoal == goal.idGoal)
      {
        exercise.goals.removeAt(i);
      }
    }
    notifyListeners();
  }

  

  // void _setError(String message) {
  //   _state = _state.copyWith(errorMessage: message, isLoading: false);
  //   notifyListeners();
  // }

  @override
  void dispose() {
    super.dispose();
  }
}