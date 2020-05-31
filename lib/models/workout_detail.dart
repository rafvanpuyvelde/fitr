import 'package:fitr/models/workout_detail_exercise.dart';

class WorkoutDetail {
  int id;
  String name;
  bool isActive;
  int amountOfSessions;
  List<ExerciseDetail> exercises;

  WorkoutDetail(
      {this.id,
      this.name,
      this.amountOfSessions,
      this.isActive,
      this.exercises});

  factory WorkoutDetail.fromJson(Map<String, dynamic> json) {
    var listOfExercises = json['exercises'] as List;
    var exercises = (listOfExercises == null)
        ? null
        : listOfExercises.map((ex) => ExerciseDetail.fromJson(ex)).toList();

    return WorkoutDetail(
        id: json['id'],
        name: json['name'],
        amountOfSessions: json['amountOfSessions'],
        isActive: json['isActive'],
        exercises: exercises);
  }
}
