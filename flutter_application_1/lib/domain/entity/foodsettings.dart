class FoodSettings{
  double _weight = 0;
  double _tall = 0;
  double _oneProtein=0;
  double _oneFats = 0;
  double _oneCar = 0;

  FoodSettings(this._weight, this._tall, this._oneProtein, this._oneFats, this._oneCar);

  Map<String, dynamic> toJson() => {
        'weight': _weight,
        'tall': _tall,
        'oneP': _oneProtein,
        'oneF': _oneFats,
        'oneC': _oneCar
      };

  // Для десериализации
  factory FoodSettings.fromJson(Map<String, dynamic> json) {
    return FoodSettings(
      json['weight'],
      json['tall'],
      json['oneP'],
      json['oneF'],
      json['oneC'],
    );
  }


  double get weight => _weight;
  double get tall => _tall;
  double get oneProtein => _oneProtein;
  double get oneFats => _oneFats;
  double get oneCar => _oneCar;

  void UpdateValue(double weightV, double tallV, double onePV, double oneFV, double oneCV)
  {
    _weight = weightV;
    _tall = tallV;
    _oneProtein = onePV;
    _oneFats = oneFV;
    _oneCar = oneCV;
  }

}