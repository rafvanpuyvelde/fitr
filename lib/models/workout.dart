import 'package:fitr/models/exercise.dart';
import 'package:fitr/models/session.dart';

class Workout {
  int _id;
  String _name;
  int _userId;
  List<Session> _sessions;
  List<Exercise> _exercises;
}
