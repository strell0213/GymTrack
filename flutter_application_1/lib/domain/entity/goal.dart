class Goal {
  int idGoal;
  String name;
  int targetWeight;
  int targetCount;

  Goal(this.idGoal,this.name,this.targetWeight, this.targetCount);

  Map<String, dynamic> toJson() => {
        'idGoal': idGoal,
        'name': name,
        'targetWeight': targetWeight,
        'targetCount': targetCount,
      };

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
      json['idGoal'],
      json['name'],
      json['targetWeight'],
      json['targetCount'],
    );
  }
}
