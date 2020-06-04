import 'package:fitr/models/workout_exercise_session.dart';
import 'package:fitr/models/workout_exercise_session_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fitr/globals.dart' as globals;

class ExerciseSessionTable extends StatefulWidget {
  final WorkoutExerciseSessionDetail data;

  ExerciseSessionTable(this.data, {Key key}) : super(key: key);

  @override
  _ExerciseSessionTableState createState() => _ExerciseSessionTableState();
}

class _ExerciseSessionTableState extends State<ExerciseSessionTable> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width - (2 * 18),
        height: 480,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 23, top: 40),
              child: Text(
                'Statistics',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    letterSpacing: 0.05),
              ),
            ),
            Expanded(
              child: ListView(
                children: getListViewChildren(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getListViewChildren() {
    var children = new List<Widget>();

    for (var sessionIndex = widget.data.sessions.length - 1;
        sessionIndex >= 0;
        sessionIndex--) {
      children.add(
          getWorkoutSession(widget.data.sessions[sessionIndex], sessionIndex));
    }

    return children;
  }

  Widget getWorkoutSession(WorkoutExerciseSession session, int sessionIndex) {
    var listOfSets = new List<Widget>();

    for (var setIndex = 0; setIndex < session.reps.length; setIndex++) {
      listOfSets.add(Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: getGroupOfExerciseSetsBySession(
              session, setIndex, session.reps.length - 1, sessionIndex)));
    }

    return new Column(children: listOfSets);
  }

  Widget getGroupOfExerciseSetsBySession(WorkoutExerciseSession session,
      int setIndex, int maxSetIndex, int sessionIndex) {
    var dateText = Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Text(
        '${session.date.day.toString()}/${session.date.month.toString()}/${session.date.year.toString()}',
        style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 14,
            letterSpacing: 0.05,
            color: globals.secondaryTextColor),
      ),
    );

    if (setIndex == 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          dateText,
          getWorkoutSets(session, setIndex, sessionIndex)
        ],
      );
    } else if (setIndex == maxSetIndex) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 28),
        child: getWorkoutSets(session, setIndex, sessionIndex),
      );
    } else {
      return getWorkoutSets(session, setIndex, sessionIndex);
    }
  }

  Widget getWorkoutSets(
      WorkoutExerciseSession session, int setIndex, int sessionIndex) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 60,
          color: globals.secondaryColor,
          child: Padding(
            padding: const EdgeInsets.only(left: 31, right: 31),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Set #${setIndex + 1}',
                  style: TextStyle(
                      color: globals.primaryTextColor,
                      letterSpacing: 0.05,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Text('${session.reps[setIndex].toString()} x',
                          style: TextStyle(
                              color: globals.secondaryTextColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.05)),
                    ),
                    getExerciseWeightProgression(
                        session, setIndex, sessionIndex)
                  ],
                )
              ],
            ),
          ),
        ));
  }

  Text getExerciseWeightProgression(
      WorkoutExerciseSession session, int setIndex, int sessionIndex) {
    double currentPerformance =
        calculateSessionPerformance(widget.data.sessions[sessionIndex]);
    double previousPerformance = calculateSessionPerformance(widget
        .data.sessions[sessionIndex > 0 ? sessionIndex - 1 : sessionIndex]);

    return Text(
        '${getIntensitySymbol(currentPerformance, previousPerformance)} ${session.weight[setIndex].toString()} kg',
        style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 17,
            letterSpacing: 0.05,
            color: getIntensityColor(currentPerformance, previousPerformance)));
  }

  double calculateSessionPerformance(WorkoutExerciseSession session) {
    double performance = 0.0;

    for (var i = 0; i < session.reps.length; i++)
      performance += session.reps[i] * session.weight[i];

    return performance;
  }

  Color getIntensityColor(
      double currentPerformance, double previousPerformance) {
    if (currentPerformance > previousPerformance) {
      return Color.fromARGB(255, 68, 195, 143);
    } else if (currentPerformance < previousPerformance) {
      return Color.fromARGB(255, 225, 87, 127);
    } else {
      return globals.secondaryTextColor;
    }
  }

  String getIntensitySymbol(
      double currentPerformance, double previousPerformance) {
    if (currentPerformance > previousPerformance) {
      return '↑';
    } else if (currentPerformance < previousPerformance) {
      return '↓';
    } else {
      return '';
    }
  }
}
