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
    var listOfReps = json['reps'] as List;
    var reps = listOfReps == null
        ? null
        : listOfReps.map((rep) => ExerciseRep.fromJson(rep)).toList();

    return ExerciseSet(
        id: json['id'],
        exerciseId: json['exerciseId'],
        weight: json['weight'].toDouble(),
        unit: json['unit'],
        usesBands: json['usesBands'],
        usesChains: json['usesChains'],
        reps: reps);
  }
}
