import 'dart:convert';
import 'dart:developer';
import 'package:fitr/models/user.dart';
import 'package:fitr/models/workout.dart';
import 'package:fitr/models/workout_exercise_session.dart';
import 'package:fitr/models/workout_exercise_session_detail.dart';
import 'package:flutter/material.dart';
import 'package:fitr/globals.dart' as globals;
import 'package:http/http.dart' as http;

enum SetVariable { reps, weight }

class WorkoutExercisePage extends StatefulWidget {
  final User user;

  WorkoutExercisePage(this.user, {Key key}) : super(key: key);

  @override
  _WorkoutExercisePageState createState() => _WorkoutExercisePageState();
}

class _WorkoutExercisePageState extends State<WorkoutExercisePage> {
  var _workoutId = 0;
  var _currentSetIndex = 0;
  var _currentExerciseIndex = 0;

  var _currentRepCount = 0;
  var _currentWeight = 0.0;
  var _currentSetPerformanceIsAltered = false;

  Workout _currentWorkout;
  Future<WorkoutExerciseSessionDetail> _futureExerciseDetail;

  WorkoutExerciseSession _newExerciseSession;

  @override
  void initState() {
    super.initState();

    fetchCurrentWorkoutId().then((workoutId) => {
          setState(() => {_workoutId = workoutId}),
          fetchCurrentWorkout().then((currentWorkout) => {
                setState(() => {_currentWorkout = currentWorkout}),
                _futureExerciseDetail = fetchExerciseSessionDetail(
                    _currentWorkout.exercises[_currentExerciseIndex].id),
                _futureExerciseDetail.then((exerciseDetail) =>
                    {setupNewExerciseSession(exerciseDetail)})
              })
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          width: MediaQuery.of(context).size.width,
          color: globals.primaryColor,
          child: FutureBuilder(
              future: _futureExerciseDetail,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Padding(
                      padding: const EdgeInsets.only(left: 18, right: 18),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          getExerciseHeader(
                              snapshot.data as WorkoutExerciseSessionDetail),
                          SizedBox(height: 32),
                          getExerciseSets(),
                          getCurrentExerciseSet(
                              snapshot.data as WorkoutExerciseSessionDetail),
                          getNextButton(
                              snapshot.data as WorkoutExerciseSessionDetail)
                        ],
                      ));
                }
              })),
    );
  }

  void setupNewExerciseSession(WorkoutExerciseSessionDetail exerciseDetail) {
    _newExerciseSession = new WorkoutExerciseSession(
      id: null,
      date: DateTime.now().toUtc(),
      sets: exerciseDetail.sessions.last.sets,
      reps: exerciseDetail.sessions.last.reps,
      weight: exerciseDetail.sessions.last.weight,
    );
  }

  Widget getExerciseHeader(WorkoutExerciseSessionDetail exerciseSessionDetail) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(exerciseSessionDetail.exerciseName,
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w900,
                  fontSize: 36,
                  letterSpacing: 0.05,
                  color: globals.primaryTextColor,
                  decoration: TextDecoration.none)),
          Text(exerciseSessionDetail.workoutName,
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
    return Expanded(
        flex: 1,
        child: FutureBuilder(
            future: _futureExerciseDetail,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Container(child: getListOfSets(snapshot));
              }
            }));
  }

  Future<int> fetchCurrentWorkoutId() async {
    var url = globals.baseApiUrl;

    final response =
        await http.get('$url/api/workouts', headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${widget.user.token}'
    });

    if (response.statusCode == 401) logout();

    List<Workout> workouts = (json.decode(response.body) as List)
        .map((i) => Workout.fromJson(i))
        .toList();

    return response.statusCode == 200
        ? workouts.singleWhere((workout) => workout?.isActive)?.id
        : null;
  }

  Future<Workout> fetchCurrentWorkout() async {
    var url = globals.baseApiUrl;

    final response = await http
        .get('$url/api/workouts/$_workoutId', headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${widget.user.token}'
    });

    if (response.statusCode == 401) logout();

    var sessionDetails = Workout.fromJson(json.decode(response.body));

    return response.statusCode == 200 ? sessionDetails : null;
  }

  Future<WorkoutExerciseSessionDetail> fetchExerciseSessionDetail(
      int exerciseId) async {
    var url = globals.baseApiUrl;

    final response = await http.get(
        '$url/api/workouts/$_workoutId/exercises/$exerciseId/sessions',
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${widget.user.token}'
        });

    if (response.statusCode == 401) logout();

    var sessionDetails =
        WorkoutExerciseSessionDetail.fromJson(json.decode(response.body));

    return response.statusCode == 200 ? sessionDetails : null;
  }

  void logout() {
    Navigator.pushNamedAndRemoveUntil(context, "/login", (r) => false);
  }

  Widget getCurrentExerciseSet(
      WorkoutExerciseSessionDetail exerciseSessionDetail) {
    return Padding(
      padding: const EdgeInsets.only(top: 46, bottom: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          getCurrentSetCount(),
          SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              getDecreaseButton(SetVariable.reps),
              getCurrentExerciseSetReps(exerciseSessionDetail),
              getIncreaseButton(SetVariable.reps)
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              getDecreaseButton(SetVariable.weight),
              getCurrentExerciseSetWeight(exerciseSessionDetail),
              getIncreaseButton(SetVariable.weight)
            ],
          )
        ],
      ),
    );
  }

  Text getCurrentSetCount() {
    return Text('Set #${_currentSetIndex + 1}',
        style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w300,
            fontSize: 24,
            letterSpacing: 0.05,
            color: globals.primaryTextColor,
            decoration: TextDecoration.none));
  }

  ClipOval getDecreaseButton(SetVariable setVariable) {
    return ClipOval(
      child: Material(
        color: globals.secondaryColor,
        child: InkWell(
          splashColor: globals.errorColor,
          onTap: () {
            setState(() {
              _currentSetPerformanceIsAltered = true;
              setVariable == SetVariable.reps
                  ? _currentRepCount--
                  : _currentWeight = _currentWeight - 0.5;
            });
          },
          child: SizedBox(
              width: 56,
              height: 56,
              child: Icon(Icons.arrow_downward, color: globals.errorColor)),
        ),
      ),
    );
  }

  ClipOval getIncreaseButton(SetVariable setVariable) {
    return ClipOval(
      child: Material(
        color: globals.secondaryColor,
        child: InkWell(
          splashColor: globals.successColor,
          onTap: () {
            setState(() {
              _currentSetPerformanceIsAltered = true;
              setVariable == SetVariable.reps
                  ? _currentRepCount++
                  : _currentWeight = _currentWeight + 0.5;
            });
          },
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

  Text getCurrentExerciseSetReps(
      WorkoutExerciseSessionDetail exerciseSessionDetail) {
    if (!_currentSetPerformanceIsAltered)
      _currentRepCount =
          exerciseSessionDetail.sessions.last.reps[_currentSetIndex];

    return Text(_currentRepCount.toString(),
        style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: 48,
            letterSpacing: 0.05,
            color: globals.primaryTextColor,
            decoration: TextDecoration.none));
  }

  Text getCurrentExerciseSetWeight(
      WorkoutExerciseSessionDetail exerciseSessionDetail) {
    if (!_currentSetPerformanceIsAltered)
      _currentWeight =
          exerciseSessionDetail.sessions.last.weight[_currentSetIndex];

    return Text(_currentWeight.toString(),
        style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: 48,
            letterSpacing: 0.05,
            color: globals.primaryTextColor,
            decoration: TextDecoration.none));
  }

  ListView getListOfSets(AsyncSnapshot snapshot) {
    var sets = new List<Widget>();

    var lastSession = snapshot.data.sessions.last as WorkoutExerciseSession;

    for (var setIndex = 0; setIndex < lastSession.reps.length; setIndex++) {
      sets.add(Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
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
                getSetIndex(setIndex),
                getPerformancesRow(setIndex, lastSession.reps[setIndex],
                    lastSession.weight[setIndex])
              ],
            ),
          ),
        ),
      ));
    }

    return ListView(
      children: sets,
    );
  }

  Text getSetIndex(int setIndex) {
    return Text(
      'Set #${setIndex + 1}',
      style: TextStyle(
          fontFamily: 'Roboto',
          decoration: TextDecoration.none,
          color: globals.primaryTextColor,
          letterSpacing: 0.05,
          fontSize: 16,
          fontWeight: FontWeight.bold),
    );
  }

  Row getPerformancesRow(int setIndex, int oldRepCount, double oldWeight) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Text('$oldRepCount x $oldWeight',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  decoration: TextDecoration.none,
                  color: globals.secondaryTextColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.05)),
        ),
        Text(
            '${_newExerciseSession.reps[setIndex]} x ${_newExerciseSession.weight[setIndex]}',
            style: TextStyle(
                fontFamily: 'Roboto',
                decoration: TextDecoration.none,
                color: globals.primaryTextColor,
                letterSpacing: 0.05,
                fontSize: 18,
                fontWeight: FontWeight.w900))
      ],
    );
  }

  Padding getNextButton(WorkoutExerciseSessionDetail exerciseSessionDetail) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 20),
      child: Center(
        child: RaisedButton(
            color: globals.secondaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            elevation: 8,
            textColor: globals.primaryTextColor,
            onPressed: () => {updateSetCounter(exerciseSessionDetail)},
            child: Text('Next')),
      ),
    );
  }

  void updateSetCounter(WorkoutExerciseSessionDetail exerciseSessionDetail) {
    var nextSetIsLastSet = _currentSetIndex + 1 ==
        exerciseSessionDetail.sessions.last.reps.length - 1;
    var nextExerciseIsLastExercise =
        _currentExerciseIndex + 1 == _currentWorkout.exercises.length - 1;

    if (nextSetIsLastSet) {
      if (!nextExerciseIsLastExercise) {
        setState(() {
          _currentExerciseIndex++;
          _currentSetPerformanceIsAltered = false;
        });
      } else {
        log('Workout done');
      }
    } else {
      setState(() {
        _newExerciseSession.reps[_currentSetIndex] = _currentRepCount;
        _newExerciseSession.weight[_currentSetIndex] = _currentWeight;
        _currentSetIndex++;
        _currentSetPerformanceIsAltered = false;
      });
    }
  }
}
