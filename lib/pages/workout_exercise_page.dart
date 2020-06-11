import 'package:fitr/models/user.dart';
import 'package:flutter/material.dart';
import 'package:fitr/globals.dart' as globals;

class WorkoutExercisePage extends StatefulWidget {
  final User user;

  WorkoutExercisePage(this.user, {Key key}) : super(key: key);

  @override
  _WorkoutExercisePageState createState() => _WorkoutExercisePageState();
}

class _WorkoutExercisePageState extends State<WorkoutExercisePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: globals.primaryColor,
        child: Padding(
          padding: const EdgeInsets.only(left: 18, right: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              getExerciseHeader(),
              SizedBox(height: 32),
              getExerciseSets(),
              getCurrentExerciseSet()
            ],
          ),
        ),
      ),
    );
  }

  Widget getExerciseHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Bench press',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w900,
                  fontSize: 36,
                  letterSpacing: 0.05,
                  color: globals.primaryTextColor,
                  decoration: TextDecoration.none)),
          Text('Full body workout',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  letterSpacing: 0.05,
                  color: globals.secondaryTextColor,
                  decoration: TextDecoration.none))
        ],
      ),
    );
  }

  Widget getExerciseSets() {
    var setIndex = 0;
    var reps = '4';
    var weight = '100';

    return Expanded(
      flex: 1,
      child: ListView(
        children: <Widget>[
          Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: globals.secondaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 31, right: 31),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Set #${setIndex + 1}',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        decoration: TextDecoration.none,
                        color: globals.primaryTextColor,
                        letterSpacing: 0.05,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Text('$reps x $weight',
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                decoration: TextDecoration.none,
                                color: globals.secondaryTextColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.05)),
                      ),
                      Text('$reps x $weight',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              decoration: TextDecoration.none,
                              color: globals.primaryTextColor,
                              letterSpacing: 0.05,
                              fontSize: 18,
                              fontWeight: FontWeight.w900))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getCurrentExerciseSet() {
    return Padding(
      padding: const EdgeInsets.only(top: 46, bottom: 69),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          getCurrentSetCount(),
          SizedBox(height: 46),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              getDecreaseButton(),
              getCurrentExerciseSetReps(),
              getIncreaseButton()
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 26, bottom: 26),
            child: Text('x',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    letterSpacing: 0.05,
                    color: globals.secondaryTextColor,
                    decoration: TextDecoration.none)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              getDecreaseButton(),
              getCurrentExerciseSetWeight(),
              getIncreaseButton()
            ],
          )
        ],
      ),
    );
  }

  Text getCurrentSetCount() {
    return Text('Set #1',
        style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w300,
            fontSize: 24,
            letterSpacing: 0.05,
            color: globals.primaryTextColor,
            decoration: TextDecoration.none));
  }

  ClipOval getDecreaseButton() {
    return ClipOval(
      child: Material(
        color: globals.secondaryColor,
        child: InkWell(
          splashColor: globals.errorColor,
          child: SizedBox(
              width: 56,
              height: 56,
              child: Icon(Icons.arrow_downward, color: globals.errorColor)),
          onTap: () {},
        ),
      ),
    );
  }

  ClipOval getIncreaseButton() {
    return ClipOval(
      child: Material(
        color: globals.secondaryColor,
        child: InkWell(
          splashColor: globals.successColor,
          onTap: () {},
          child: SizedBox(
              width: 56,
              height: 56,
              child: Icon(
                Icons.arrow_upward,
                color: globals.successColor,
              )),
        ),
      ),
    );
  }

  Text getCurrentExerciseSetReps() {
    return Text('6',
        style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: 48,
            letterSpacing: 0.05,
            color: globals.primaryTextColor,
            decoration: TextDecoration.none));
  }

  Text getCurrentExerciseSetWeight() {
    return Text('80',
        style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: 48,
            letterSpacing: 0.05,
            color: globals.primaryTextColor,
            decoration: TextDecoration.none));
  }
}
