class Food {
  int _idFood;
  String _name;
  double _calories;
  double _proteins;
  double _fats;
  double _carbohydrates;
  String _date;
  bool _isCheckForAdd=false;

  Food(this._idFood, this._name, this._calories, this._proteins, this._fats, this._carbohydrates, this._date);

  Map<String, dynamic> toJson() => {
    'id': _idFood,
    'name': _name,
    'calories': _calories,
    'proteins': _proteins,
    'fats': _fats,
    'carbohydrates': _carbohydrates,
    'date': _date
  };

  // Для десериализации
  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      json['id'],
      json['name'],
      json['calories'],
      json['proteins'],
      json['fats'],
      json['carbohydrates'],
      json['date']
    );
  }

  int get idFood => _idFood;
  String get name => _name;
  double get calories => _calories;
  double get proteins => _proteins;
  double get fats => _fats;
  double get carbohydrates => _carbohydrates;
  String get date => _date; 

  bool get isCheckForAdd => _isCheckForAdd;

  set isCheckForAdd(bool value)
  {
    _isCheckForAdd = value;
  }

  set calories(double value)
  {
    _calories = value;
  }

  set proteins(double value)
  {
    _proteins = value;
  }

  set fats(double value)
  {
    _fats = value;
  }

  set carbohydrates(double value)
  {
    _carbohydrates = value;
  }
}