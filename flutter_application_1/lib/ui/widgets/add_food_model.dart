import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/entity/food.dart';
import 'package:flutter_application_1/domain/services/food_service.dart';
import 'package:flutter_application_1/ui/widgets/food_model.dart';
class AddFoodState{
  final List<Food> foods;
  final bool isLoading;
  final String? errorMessage;

  AddFoodState({
    required this.foods,
    this.isLoading=false,
    this.errorMessage,
  });

  AddFoodState copyWith({
    List<Food>? foods,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AddFoodState(
      foods: foods ?? this.foods,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}
class AddFoodModel extends ChangeNotifier {
  late AddFoodState _state;

  TextEditingController nameController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();
  TextEditingController proteinsController = TextEditingController();
  TextEditingController fatsController = TextEditingController();
  TextEditingController carbohydratesController = TextEditingController();

  final FoodService _foodService = FoodService();
  final FoodModel _foodModel;

  bool isEdit = false;
  bool viewButton=false;
  Food? curFood = null;

  AddFoodModel(this._foodModel, this.isEdit, this.curFood){
    _state = AddFoodState(foods: []);
    if(isEdit)
    {
      setFood();
    }
    else GetFoodsList();

  }

  AddFoodState get state => _state;

  Future<void> GetFoodsList() async{
    _setLoading(true);
    try{
      final foods = await _foodService.loadFoods();
      final seenNames = <String>{};
      final uniqueFoods = foods.where((food) => seenNames.add(food.name)).toList();

      _state = _state.copyWith(foods: uniqueFoods, isLoading: false);
    } catch (e) {
      _state = _state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
    notifyListeners();
  }

  Future<void> addNewFood() async{
    int newID = await _foodService.newID();
    final foods = await _foodService.loadFoods();

    Food newFood = Food(newID, nameController.text, 
      double.parse(caloriesController.text), double.parse(proteinsController.text),
      double.parse(fatsController.text), double.parse(carbohydratesController.text),
      DateTime.now().toString());

    foods.add(newFood);
    await _foodService.saveFoods(foods);
    _foodModel.UpdateAll();
  }

  Future<void> editFood() async{
    curFood!.calories = double.parse(caloriesController.text);
    curFood!.proteins = double.parse(proteinsController.text);
    curFood!.fats = double.parse(fatsController.text);
    curFood!.carbohydrates = double.parse(carbohydratesController.text);

    await _foodService.updateFood(curFood!);
    _foodModel.UpdateAll();
  }

  Future<void> setFood() async{
    nameController.text = curFood!.name.toString();
    caloriesController.text = curFood!.calories.toString();
    proteinsController.text = curFood!.proteins.toString();
    fatsController.text = curFood!.fats.toString();
    carbohydratesController.text = curFood!.carbohydrates.toString();
    notifyListeners();
  }

  Future<void> addChooseFood() async{
    final foods = state.foods;
    for (int i = 0; i<foods.length; i++)
    {
      if(foods[i].isCheckForAdd)
      {
        int newID = await _foodService.newID();

        final foodsDB = await _foodService.loadFoods();
        Food newFood = Food(newID, foods[i].name, foods[i].calories,
          foods[i].proteins, foods[i].fats, 
          foods[i].carbohydrates, DateTime.now().toString());

        foodsDB.add(newFood);
        await _foodService.saveFoods(foodsDB);
      }
    }
    _foodModel.UpdateAll();
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