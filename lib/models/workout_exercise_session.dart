class WorkoutExerciseSession {
  int id;
  DateTime date;
  int sets;
  List<int> reps;
  List<double> weight;

  WorkoutExerciseSession(
      {this.id, this.date, this.sets, this.reps, this.weight});

  factory WorkoutExerciseSession.fromJson(Map<String, dynamic> json) {
    var listOfWeights = json['weight'] as List;
    var weights = new List<double>();

    for (var weight in listOfWeights) {
      String str = weight?.toString() ?? "0";
      double wgt = double.parse(str);
      weights.add(wgt);
    }

    return WorkoutExerciseSession(
        id: json['id'],
        date: DateTime.parse(json['date']),
        sets: json['sets'],
        reps: json['reps'].cast<int>(),
        weight: weights);
  }
}
