class Goal {
  int idGoal;
  String name;
  int targetWeight;
  int targetCount;
  bool isFinish;

  Goal(this.idGoal,this.name,this.targetWeight, this.targetCount, this.isFinish);

  Map<String, dynamic> toJson() => {
        'idGoal': idGoal,
        'name': name,
        'targetWeight': targetWeight,
        'targetCount': targetCount,
        'isFinish': isFinish ? 1 : 0,
      };

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
      json['idGoal'],
      json['name'],
      json['targetWeight'],
      json['targetCount'],
      json['isFinish'] ?? 0,
    );
  }
}
