class Exercise
{
  String _name;
  int _weight;
  int _count;

  Exercise(this._name, this._count, this._weight);

    // Для сериализации
  Map<String, dynamic> toJson() => {
        'name': _name,
        'weight': _weight,
        'count': _count,
      };

  // Для десериализации
  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      json['name'],
      json['count'],
      json['weight'],
    );
  }

  String get name => _name;
  int get weight => _weight;
  int get count => _count;

  set weight(int value) {
    _weight = value < 0 ? 0 : value; // Пример с валидацией
  }

  set count(int value) {
    _count = value < 0 ? 0 : value; // Пример с валидацией
  }
}