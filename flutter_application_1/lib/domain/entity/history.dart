class History {
  int _id;
  String _name;
  int _weight;
  int _count;
  String _createAt;
  int _idExercise;

  History(this._id,this._name, this._weight, this._count, this._createAt,this._idExercise);
  
  Map<String, dynamic> toJson() => {
        'id': _id,
        'name': _name,
        'weight': _weight,
        'count': _count,
        'createAt': _createAt,
        'idExercise': _idExercise
      };

  // Для десериализации
  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      json['id'],
      json['name'],
      json['weight'],
      json['count'],
      json['createAt'],
      json['idExercise']
    );
  }

  String get name => _name;
  int get weigth => _weight;
  int get count => _count;
  DateTime get createAt => DateTime.parse(_createAt);
  int get id => _id;
  int get idExercise => _idExercise;
}