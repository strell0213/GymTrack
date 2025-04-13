import 'package:flutter_application_1/domain/entity/exercise.dart';

class Dayofweek {
  String _name;
  List<Exercise> _exercises;

  Dayofweek(this._name, this._exercises);

    // Для сериализации
  Map<String, dynamic> toJson() => {
        'name': _name,
        'exercises': _exercises,
      };

  // Для десериализации
  factory Dayofweek.fromJson(Map<String, dynamic> json) {
    return Dayofweek(
      json['name'],
      json['exercises'],
    );
  }

  String get name => _name;
  List<Exercise> get exercises => _exercises;
}