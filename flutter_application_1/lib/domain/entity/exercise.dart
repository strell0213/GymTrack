class Exercise
{
  String _name;
  int _weight;
  int _count;
  String _day;
  String _howDid;

  Exercise(this._name, this._count, this._weight, this._day,this._howDid);

    // Для сериализации
  Map<String, dynamic> toJson() => {
        'name': _name,
        'weight': _weight,
        'count': _count,
        'day': _day,
        'howdid': _howDid,
      };

  // Для десериализации
  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      json['name'],
      json['count'],
      json['weight'],
      json['day'],
      json['howdid'] ?? '',
    );
  }

  String get name => _name;
  int get weight => _weight;
  int get count => _count;
  String get day => _day;
  String get howDid => _howDid;

  set name(String value){
    _name = value;
  }

  set weight(int value) {
    _weight = value < 0 ? 0 : value; // Пример с валидацией
  }

  set count(int value) {
    _count = value < 0 ? 0 : value; // Пример с валидацией
  }

  set howDid(String value){
    _howDid = value;
  }
}