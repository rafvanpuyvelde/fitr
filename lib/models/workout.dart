import 'package:fitr/models/exercise.dart';
import 'package:fitr/models/session.dart';

class Workout {
  int id;
  String name;
  int userId;
  List<Session> sessions;
  List<Exercise> exercises;

  Workout({this.id, this.name, this.userId, this.sessions, this.exercises});

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
        id: json['id'],
        name: json['name'],
        userId: json['userId'],
        sessions: json['sessions'],
        exercises: json['exercises']
            .forEach((exercise) => Exercise.fromJson(exercise)));
  }
}
