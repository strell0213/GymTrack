import 'package:flutter/material.dart';

class AddViewModel extends ChangeNotifier{

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
}