import 'package:fitr/models/exercise_rep.dart';
import 'package:fitr/models/unit.dart';

class ExerciseSet {
  int id;
  int exerciseId;
  double weight;
  Unit unit;
  bool usesBands;
  bool usesChains;
  List<ExerciseRep> reps;

  ExerciseSet(
      {this.id,
      this.exerciseId,
      this.weight,
      this.unit,
      this.usesBands,
      this.usesChains,
      this.reps});

  factory ExerciseSet.fromJson(Map<String, dynamic> json) {
    return ExerciseSet(
        id: json['id'],
        exerciseId: json['exerciseId'],
        weight: json['weight'],
        unit: json['unit'],
        usesBands: json['usesBands'],
        usesChains: json['usesChains'],
        reps: json['reps'].forEach((rep) => new ExerciseRep.fromJson(rep)));
  }
}
