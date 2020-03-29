import 'package:flutter/material.dart';

class MyWorkouts extends StatefulWidget {
  MyWorkouts({Key key}) : super(key: key);

  @override
  _MyWorkoutsState createState() => _MyWorkoutsState();
}

class _MyWorkoutsState extends State<MyWorkouts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          child: Text('My workouts',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 254),
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.5))),
    );
  }
}
