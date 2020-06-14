import 'package:fitr/models/user.dart';
import 'package:fitr/models/workout_detail_exercise.dart';
import 'package:fitr/pages/exercise_detail_page.dart';
import 'package:flutter/material.dart';

class ExerciseCard extends StatefulWidget {
  final ExerciseDetail exercise;
  final User user;
  final int workoutId;
  final String workoutName;

  ExerciseCard(this.exercise, this.user, this.workoutId, this.workoutName,
      {Key key})
      : super(key: key);

  @override
  _ExerciseCardState createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  @override
  Widget build(BuildContext context) {
    double _vw = MediaQuery.of(context).size.width;

    return Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5, left: 15),
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
                width: _vw / 1.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(widget.exercise.name,
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: (_vw / 1.7) / 8.3,
                                  fontWeight: FontWeight.w800,
                                  fontStyle: FontStyle.normal)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal)),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Text(getExerciseTrend(),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: (_vw / 1.7) / 2.6,
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
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  onExerciseTapped(ExerciseDetail exercise) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ExerciseDetailPage(
                exercise, widget.user, widget.workoutId, widget.workoutName)));
  }

  String getExerciseTrend() {
    var trend = widget.exercise.trend.toString();

    if (trend.length > 0) trend = trend.replaceFirst(new RegExp(r'0'), '');

    return trend;
  }
}
