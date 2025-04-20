class Goal {
  String name;
  int targetWeight;
  int targetCount;

  Goal(this.name,this.targetWeight, this.targetCount);

  Map<String, dynamic> toJson() => {
        'name': name,
        'targetWeight': targetWeight,
        'targetCount': targetCount,
      };

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
      json['name'],
      json['targetWeight'],
      json['targetCount'],
    );
  }
}
