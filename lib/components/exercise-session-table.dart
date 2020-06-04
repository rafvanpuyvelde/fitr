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
  List<Widget> getListViewChildren() {
    var children = new List<Widget>();

    for (var i = 0; i < widget.data.sessions.length; i++) {
      children.add(getWorkoutSession(widget.data.sessions[i]));
    }

    return children;
  }

  Widget getWorkoutSession(WorkoutExerciseSession session) {
    var listOfSets = new List<Widget>();

    for (var sessionIndex = 0;
        sessionIndex < session.reps.length;
        sessionIndex++) {
      listOfSets.add(Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: getGroupOfExerciseSetsBySession(
              session, sessionIndex, session.reps.length - 1)));
    }

    return new Column(children: listOfSets);
  }

  Widget getGroupOfExerciseSetsBySession(
      WorkoutExerciseSession session, int sessionIndex, int maxSessionIndex) {
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

    if (sessionIndex == 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[dateText, getWorkoutSets(session, sessionIndex)],
      );
    } else if (sessionIndex == maxSessionIndex) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 28),
        child: getWorkoutSets(session, sessionIndex),
      );
    } else {
      return getWorkoutSets(session, sessionIndex);
    }
  }

  Widget getWorkoutSets(WorkoutExerciseSession session, int setIndex) {
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
                    Text('${session.reps[setIndex].toString()} x'),
                    Text('↑ ${session.weight[setIndex].toString()}')
                  ],
                )
              ],
            ),
          ),
        ));
  }

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
}
