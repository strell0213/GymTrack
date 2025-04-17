import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/entity/exercise.dart';
import 'package:flutter_application_1/ui/widgets/main_model.dart';

class DetailViewModel extends ChangeNotifier {
  final Exercise exercise;
  final ExerciseViewModel exerciseVM;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController howDidController = TextEditingController();
  final TextEditingController countController = TextEditingController();

  DetailViewModel(this.exercise, this.exerciseVM) {
    weightController.text = exercise.weight.toString();
    howDidController.text = exercise.howDid;
    countController.text = exercise.count.toString();
    nameController.text = exercise.name;
  }

  void saveWeight(BuildContext context) {
    exercise.weight = int.tryParse(weightController.text) ?? 0;
    exerciseVM.updateExercise(exercise);
    _showSnackBar(context);
  }

  void saveHowDid(BuildContext context) {
    exercise.howDid = howDidController.text;
    exerciseVM.updateExercise(exercise);
    _showSnackBar(context);
  }

  void saveCount(BuildContext context) {
    exercise.count = int.tryParse(countController.text) ?? 0;
    exerciseVM.updateExercise(exercise);
    _showSnackBar(context);
  }

  void saveName(BuildContext context){
    exercise.name = nameController.text;
    exerciseVM.updateExercise(exercise);
    _showSnackBar(context);
    notifyListeners();
  }

  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Успешно сохранено')),
    );
  }

  @override
  void dispose() {
    weightController.dispose();
    howDidController.dispose();
    super.dispose();
  }
}
