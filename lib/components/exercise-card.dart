import 'dart:math';
import 'package:fitr/models/user.dart';
import 'package:fitr/models/workout_detail_exercise.dart';
import 'package:fitr/pages/exercise_detail_page.dart';
import 'package:flutter/material.dart';

class ExerciseCard extends StatefulWidget {
  final ExerciseDetail exercise;
  final User user;
  final int workoutId;

  ExerciseCard(this.exercise, this.user, this.workoutId, {Key key})
      : super(key: key);

  @override
  _ExerciseCardState createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  getRandomGradient() {
    const gradients = [
      [Color.fromARGB(255, 1, 163, 255), Color.fromARGB(255, 0, 119, 255)],
      [Color.fromARGB(255, 254, 113, 112), Color.fromARGB(255, 254, 85, 85)],
      [Color.fromARGB(255, 74, 192, 168), Color.fromARGB(255, 24, 151, 172)],
      [Color.fromARGB(255, 249, 178, 191), Color.fromARGB(255, 146, 44, 249)],
      [Color.fromARGB(255, 237, 155, 28), Color.fromARGB(255, 249, 207, 69)],
    ];
    var random = new Random();
    return gradients[random.nextInt(gradients.length)];
  }

  String getExerciseName() {
    return (widget.exercise.name.length >= 12)
        ? widget.exercise.name.substring(0, 11) + '...'
        : widget.exercise.name;
  }

  onExerciseTapped(ExerciseDetail exercise) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                ExerciseDetailPage(exercise, widget.user, widget.workoutId)));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
            top: 30.0, bottom: 30.0, left: 15.0, right: 0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () => onExerciseTapped(widget.exercise),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                      Color.fromARGB(255, 249, 178, 191),
                      Color.fromARGB(255, 146, 44, 249)
                    ])),
                width: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(top: 50, left: 40),
                        child: Text(getExerciseName(),
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 29,
                                fontWeight: FontWeight.w800,
                                fontStyle: FontStyle.normal))),
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Row(
                        children: <Widget>[
                          Text('Max - ' + widget.exercise.record.toString(),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal)),
                          Padding(
                            padding: const EdgeInsets.only(left: 2.0),
                            child: Text(widget.exercise.unit.toString(),
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal)),
                          )
                        ],
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 24, bottom: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Text(widget.exercise.trend.toString(),
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 96,
                                    fontWeight: FontWeight.w800,
                                    fontStyle: FontStyle.normal,
                                    letterSpacing: -8)),
                            Text('%',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 36,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
