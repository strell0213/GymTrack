import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/entity/food.dart';
import 'package:flutter_application_1/domain/services/foodSettings_service.dart';
import 'package:flutter_application_1/domain/services/food_service.dart';

class FoodState {
  final List<Food> foods;
  final bool isLoading;
  final String? errorMessage;

  FoodState({
    required this.foods,
    this.isLoading = false,
    this.errorMessage,
  });

  // Копирование состояния с возможностью изменения
  FoodState copyWith({
    List<Food>? foods,
    bool? isLoading,
    String? errorMessage,
  }) {
    return FoodState(
      foods: foods ?? this.foods,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class FoodModel extends ChangeNotifier {
  final FoodService _foodService = FoodService();
  final FoodsettingsService _foodsettingsService = FoodsettingsService();

  double CallValue = 0;
  double ProteinValue=0;
  double FatsValue=0;
  double Carbohydrates=0;

  double fullCall = 0;
  double fullProtien = 0;
  double fullFats = 0;
  double fullCarbohydrates=0;

  FoodState _state = FoodState(foods: []);
  FoodState get state => _state;

  FoodModel()
  {
    UpdateAll();
  }

  Future<void> UpdateAll() async
  {
    await loadFoods();
    CheckParametrs();
    loadSettings();
  }

  Future<void> loadFoods() async
  {
    _setLoading(true);
    try{
      final foods = await _foodService.loadFoods();

      final now = DateTime.now();
      final filteredFoods = foods.where((x) {
        try {
          final foodDate = DateTime.parse(x.date);
          return foodDate.year == now.year &&
                foodDate.month == now.month &&
                foodDate.day == now.day;
        } catch (_) {
          return false; // если дата не парсится — игнорируем
        }
      }).toList();

      _state = _state.copyWith(foods: filteredFoods, isLoading: false, errorMessage: null);
    }
    catch (e){
      _state = _state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
    notifyListeners();
  }

  Future<void> loadSettings() async{
    final settings = await _foodsettingsService.loadFoodSettings();
    final setting = settings[0];

    fullProtien = (setting.weight * setting.oneProtein).roundToDouble();
    fullFats = (setting.weight * setting.oneFats).roundToDouble();
    fullCarbohydrates = (setting.weight * setting.oneCar).roundToDouble();
  }

  Future<void> CheckParametrs() async
  {
    double call=0;
    double proteins = 0;
    double fats = 0;
    double carbohydrates=0;
    for(var food in state.foods)
    {
      call += food.calories;
      proteins += food.proteins;
      fats += food.fats;
      carbohydrates += food.carbohydrates;
    }

    CallValue = call;
    ProteinValue = proteins;
    FatsValue = fats;
    Carbohydrates = carbohydrates;
    notifyListeners();
  }

  double GetNowProteins()
  {
    double ratio = fullProtien != 0 ? (ProteinValue / fullProtien) : 0;
    return ratio;
  }

  double GetNowFats()
  {
    double ratio = fullFats != 0 ? (FatsValue / fullFats) : 0;
    return ratio;
  }

  double GetNowCar()
  {
    double ratio = fullCarbohydrates != 0 ? (Carbohydrates / fullCarbohydrates) : 0;
    return ratio;
  }

  Future<void> deleteFood(Food food) async
  {
    final foods = await _foodService.loadFoods();
    for(int i = 0; i < foods.length; i++)
    {
      if(foods[i].idFood == food.idFood)
      {
        foods.removeAt(i);
      }
    }
    await _foodService.saveFoods(foods);
    await UpdateAll();
  }

  void _setLoading(bool value) {
    _state = _state.copyWith(isLoading: value, errorMessage: null);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}