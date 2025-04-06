class Exercise
{
  final String _name;
  final int _weight;
  final int _count;

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
}