import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/entity/food.dart';
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

  String CallValue = "0";
  String ProteinValue="0";
  String FatsValue="0";
  String Carbohydrates="0";

  FoodState _state = FoodState(foods: []);
  FoodState get state => _state;

  FoodModel()
  {
    loadFoods();
  }

  Future<void> loadFoods() async
  {
    _setLoading(true);
    try{
      final foods = await _foodService.loadFoods();
      _state = _state.copyWith(foods: foods, isLoading: false, errorMessage: "");
    }
    catch (e){
      _state = _state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
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