class ExerciseRep {
  int id;
  int setId;
  int exerciseId;

  ExerciseRep({this.id, this.setId, this.exerciseId});

  factory ExerciseRep.fromJson(Map<String, dynamic> json) {
    return ExerciseRep(
        id: json['id'], setId: json['setId'], exerciseId: json['exerciseId']);
  }
}
