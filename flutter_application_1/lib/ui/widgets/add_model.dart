import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/entity/exercise.dart';

import 'package:flutter_application_1/ui/widgets/main_model.dart';

class AddViewModel extends ChangeNotifier{
  final ExerciseViewModel exerciseVM;

  final TextEditingController searchController = TextEditingController();
  late String selectedDay;
  late String selectedType;
  late int newID;

  AddViewModel(this.exerciseVM);

  void addExercise(BuildContext context) async{
    final text = searchController.text;
    final isValid = checkControllerText(text);
    newID =  await exerciseVM.newID();

    if(!checkSelectDay(context)) return;

    if (isValid) {
      exerciseVM.addExercise(Exercise(newID, text, 0, 0, getDayForAdd(selectedDay),'',selectedType,0));
      Navigator.pop(context);
    } else {
      showMessage(context, 'Вы ничего не ввели!');
    }
  }

  bool checkSelectDay(BuildContext context){
    if (selectedDay.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Выберите день недели!')),
      );
      return false; 
    }
    return true;
  }

  void showMessage(BuildContext context,String txt){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(txt)),
      );
      return;
  }

  bool checkControllerText(String text) {
    return text.trim().isNotEmpty;
  }

  String getDayForAdd(String? selectedDay)
  {
    switch(selectedDay)
    {
      case "Пн":
        return "mon";
      case "Вт":
        return "tue";
      case "Ср":
        return "wed";
      case "Чт":
        return "thu";
      case "Пт":
        return "fri";
      case "Сб":
        return "sat";
      case "Вс":
        return "sun";
      default: 
        return "";
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}