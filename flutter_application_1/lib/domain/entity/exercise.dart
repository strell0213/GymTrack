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
  int _numPP;

  List<Goal> goals = [];

  Exercise(this._id,this._name, this._count, this._weight, this._day,this._howDid,this._typeExercise, this._numPP);

    // Для сериализации
  Map<String, dynamic> toJson() => {
        'id': _id,
        'name': _name,
        'weight': _weight,
        'count': _count,
        'day': _day,
        'howdid': _howDid,
        'typeExercice':_typeExercise,
        'numPP': _numPP,
        'isDone': isDone ? 1 : 0,
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
      json['numPP'] ?? 0,
    );

    exercise.isDone = json['isDone'] == 1;

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
  int get numPP => _numPP;

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

  set numPP(int value){
    _numPP=value;
  }

  int getNewGoalID()
  {
    if(goals.isEmpty) return 0;

    final maxID = goals.map((e) => e.idGoal).reduce((a, b) => a > b ? a : b);
    return maxID + 1;
  }

  Goal getActualGoal()
  {
    for(var goal in goals)
    {
      if(goal.targetWeight > weight) {return goal;}
      else if(goal.targetCount > count) {return goal;}
    }
    return Goal(0, '', 0, 0, true);
  }

  int getCountNotFinishGoals(){
    return goals.length;
  }

  void checkGoals(){
    for(var goal in goals)
    {
      if(goal.targetWeight <= weight) {goal.isFinish=true;}
      else {goal.isFinish=false;}
      if(goal.targetCount <= count) {goal.isFinish=true;}
      else {goal.isFinish=false;}
    }
  }
}