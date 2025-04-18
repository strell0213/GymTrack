class History {
  String _name;
  int _weight;
  int _count;
  String _createAt;

  History(this._name, this._weight, this._count, this._createAt);
  
  Map<String, dynamic> toJson() => {
        'name': _name,
        'weight': _weight,
        'count': _count,
        'createAt': _createAt
      };

  // Для десериализации
  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      json['name'],
      json['weight'],
      json['count'],
      json['createAt']
    );
  }

  String get name => _name;
  int get weigth => _weight;
  int get count => _count;
  DateTime get createAt => DateTime.parse(_createAt);

}