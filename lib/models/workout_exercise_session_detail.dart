import 'package:fitr/models/workout_exercise_session.dart';

class WorkoutExerciseSessionDetail {
  int workoutId;
  String workoutName;
  int exerciseId;
  String exerciseName;
  List<WorkoutExerciseSession> sessions;

  WorkoutExerciseSessionDetail(
      {this.workoutId,
      this.workoutName,
      this.exerciseId,
      this.exerciseName,
      this.sessions});

  factory WorkoutExerciseSessionDetail.fromJson(Map<String, dynamic> json) {
    var listOfSessions = json['sessions'] as List;
    var sessions = (listOfSessions == null)
        ? null
        : listOfSessions
            .map((ex) => WorkoutExerciseSession.fromJson(ex))
            .toList();

    return WorkoutExerciseSessionDetail(
        workoutId: json['workoutId'],
        workoutName: json['workoutName'],
        exerciseId: json['exerciseId'],
        exerciseName: json['exerciseName'],
        sessions: sessions);
  }
}
