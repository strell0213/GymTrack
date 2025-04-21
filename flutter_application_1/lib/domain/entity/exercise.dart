import 'package:flutter_application_1/domain/entity/goal.dart';

class Exercise
{
  int _id;
  String _name;
  int _weight;
  int _count;
  String _day;
  String _howDid;
  String _typeExercise;
  bool isDone = false;

  List<Goal> goals = [];

  Exercise(this._id,this._name, this._count, this._weight, this._day,this._howDid,this._typeExercise);

    // Для сериализации
  Map<String, dynamic> toJson() => {
        'id': _id,
        'name': _name,
        'weight': _weight,
        'count': _count,
        'day': _day,
        'howdid': _howDid,
        'typeExercice':_typeExercise,
        'goals': goals.map((g) => g.toJson()).toList(),
      };

  // Для десериализации
  factory Exercise.fromJson(Map<String, dynamic> json) {
    final exercise = Exercise(
      json['id'] ?? '',
      json['name'],
      json['count'],
      json['weight'],
      json['day'],
      json['howdid'] ?? '',
      json['typeExercice'] ?? '',
    );

    if (json['goals'] != null) {
      exercise.goals = List<Goal>.from(
        json['goals'].map((x) => Goal.fromJson(x)),
      );
    }

    return exercise;
  }

  int get id => _id;
  String get name => _name;
  int get weight => _weight;
  int get count => _count;
  String get day => _day;
  String get howDid => _howDid;
  String get typeExercice => _typeExercise;

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
  
  set id(int value){
    _id = value;
  }
}