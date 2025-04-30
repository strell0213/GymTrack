import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/domain/entity/exercise.dart';
import 'package:flutter_application_1/domain/entity/goal.dart';
import 'package:flutter_application_1/domain/services/exercise_service.dart';
import 'package:flutter_application_1/domain/services/goal_service.dart';
import 'package:flutter_application_1/ui/widgets/main_model.dart';

class GoalAddViewModal extends ChangeNotifier {
  final TextEditingController nameController=TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final ExerciseService _exerciseService;
  final Exercise exercise;

  GoalAddViewModal(this.exercise, this._exerciseService)
  {
    weightController.text=exercise.weight.toString();
  }

  Future<void> addGoal(BuildContext context) async{
    final nameGoal = nameController.text;
    final weightGoal = int.tryParse(weightController.text);
    Goal goal = Goal(exercise.getNewGoalID(), nameGoal, weightGoal!, 0);

    exercise.goals.add(goal);
    try{
      await _exerciseService.updateExercise(exercise);
      _showSnackBar(context);
    }
    catch(e){
      _showSnackBarError(context, e.toString());
    }
  }

  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Успешно сохранено')),
    );
  }

  void _showSnackBarError(BuildContext context, String errormsg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Ошибка: $errormsg')),
    );
  }
}