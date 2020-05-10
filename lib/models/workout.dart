import 'package:fitr/models/exercise.dart';
import 'package:fitr/models/session.dart';

class Workout {
  int id;
  String name;
  int userId;
  bool isActive;
  List<Session> sessions;
  List<Exercise> exercises;

  Workout(
      {this.id,
      this.name,
      this.userId,
      this.isActive,
      this.sessions,
      this.exercises});

  factory Workout.fromJson(Map<String, dynamic> json) {
    var listOfExercises = json['exercises'] as List;
    var exercises = listOfExercises.map((ex) => Exercise.fromJson(ex)).toList();

    return Workout(
        id: json['id'],
        name: json['name'],
        userId: json['userId'],
        isActive: json['isActive'],
        sessions: json['sessions'],
        exercises: exercises);
  }
}
