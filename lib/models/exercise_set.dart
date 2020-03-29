import 'package:fitr/models/exercise_rep.dart';
import 'package:fitr/models/unit.dart';

class ExerciseSet {
  int _id;
  int _exerciseId;
  double _weight;
  Unit _unit;
  bool _usesBands;
  bool _usesChains;
  List<ExerciseRep> _reps;
}
