import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/services/foodSettings_service.dart';

class SettingsfoodsModel extends ChangeNotifier {
  TextEditingController weightController = TextEditingController();
  TextEditingController tallController = TextEditingController();
  TextEditingController oneProteinController = TextEditingController();
  TextEditingController oneFatsController = TextEditingController();
  TextEditingController oneCarControllet = TextEditingController();

  final FoodsettingsService _foodsettingsService = FoodsettingsService();

  SettingsfoodsModel(){
    loadCurSettings();  
  }
  
  Future<void> loadCurSettings() async{
    final settings = await _foodsettingsService.loadFoodSettings();

    weightController.text = settings[0].weight.toString();
    tallController.text = settings[0].tall.toString();
    oneProteinController.text = settings[0].oneProtein.toString();
    oneFatsController.text = settings[0].oneFats.toString();
    oneCarControllet.text = settings[0].oneCar.toString();
    notifyListeners();
  }

  Future<bool> checkEditingNULL() async{
    if(weightController.text.isEmpty || tallController.text.isEmpty || oneProteinController.text.isEmpty || oneFatsController.text.isEmpty || oneCarControllet.text.isEmpty)
    {
      return false;
    }
    else return true;
  }

  Future<void> saveFoodSettings() async{
    final settings = await _foodsettingsService.loadFoodSettings();

    settings[0].UpdateValue(
      weightController.text as double,
      tallController.text as double,
      oneProteinController.text as double,
      oneFatsController.text as double,
      oneCarControllet.text as double);

    await _foodsettingsService.saveFoodSettings(settings);
    notifyListeners();
  }


}