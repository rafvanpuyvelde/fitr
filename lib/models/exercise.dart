import 'package:fitr/models/exercise_set.dart';

class Exercise {
  int id;
  String name;
  List<ExerciseSet> sets;

  Exercise({this.id, this.name, this.sets});

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'],
      name: json['name'],
      sets: json['sets'],
    );
  }
}
