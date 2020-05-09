import 'package:fitr/models/workout.dart';
import 'package:flutter/material.dart';

class WorkoutDetailPage extends StatefulWidget {
  final Workout workout;

  WorkoutDetailPage({this.workout, Key key}) : super(key: key);

  @override
  _WorkoutDetailPageState createState() => _WorkoutDetailPageState();
}

class _WorkoutDetailPageState extends State<WorkoutDetailPage> {
  getExercises() {
    var exercises = new List<Text>();

    if (widget.workout.exercises != null &&
        widget.workout.exercises.length > 0) {
      for (var exercise in widget.workout.exercises) {
        exercises.add(new Text(exercise.name));
      }
    } else {
      exercises.add(new Text('No exercises yet ...'));
    }

    return exercises;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 85.0),
              child: Text(widget.workout.name,
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 254),
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                      decoration: TextDecoration.none)),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(top: 40.0, bottom: 40.0),
              child: Container(
                child: ListView(
                  children: getExercises(),
                ),
              ),
            )),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  OutlineButton(
                    onPressed: null,
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 11, 127, 222),
                        width: 1,
                        style: BorderStyle.solid),
                    disabledBorderColor: Colors.white,
                    child: Text(
                      'Set active',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: RaisedButton(
                      color: Color.fromARGB(255, 11, 127, 222),
                      onPressed: () {},
                      child: const Text('Start workout',
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
