class Goal {
  int idGoal;
  String name;
  int targetWeight;
  int targetCount;
  bool isFinish=false;

  Goal(this.idGoal,this.name,this.targetWeight, this.targetCount);

  Map<String, dynamic> toJson() => {
        'idGoal': idGoal,
        'name': name,
        'targetWeight': targetWeight,
        'targetCount': targetCount,
        'isFinish': isFinish ? 1 : 0,
      };

  factory Goal.fromJson(Map<String, dynamic> json) {
    final goal = Goal(
      json['idGoal'],
      json['name'],
      json['targetWeight'],
      json['targetCount']
    );

    goal.isFinish = json['isFinish'] == 1;

    return goal;
  }
}
