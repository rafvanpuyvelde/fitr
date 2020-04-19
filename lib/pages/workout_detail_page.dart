import 'package:fitr/models/workout.dart';
import 'package:flutter/material.dart';

class WorkoutDetailPage extends StatefulWidget {
  final Workout workout;

  WorkoutDetailPage(this.workout, {Key key}) : super(key: key);

  @override
  _WorkoutDetailPageState createState() => _WorkoutDetailPageState();
}

class _WorkoutDetailPageState extends State<WorkoutDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.workout.name),
    );
  }
}
