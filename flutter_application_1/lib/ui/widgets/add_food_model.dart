import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/entity/food.dart';
import 'package:flutter_application_1/domain/services/food_service.dart';

class AddFoodModel extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();
  TextEditingController proteinsController = TextEditingController();
  TextEditingController fatsController = TextEditingController();
  TextEditingController carbohydratesController = TextEditingController();

  final FoodService _foodService = FoodService();

  AddFoodModel();

  Future<void> addNewFood() async{
    int newID = await _foodService.newID();
    final foods = await _foodService.loadFoods();

    Food newFood = Food(newID, nameController.text, 
      double.parse(caloriesController.text), double.parse(proteinsController.text),
      double.parse(fatsController.text), double.parse(carbohydratesController.text),
      DateTime.now().toString());

    foods.add(newFood);
    await _foodService.saveFoods(foods);
  }

}