import 'dart:convert';
import 'package:fitr/components/exercise-card.dart';
import 'package:fitr/components/side-menu.dart';
import 'package:fitr/models/user.dart';
import 'package:fitr/models/workout.dart';
import 'package:fitr/models/workout_detail.dart';
import 'package:flutter/material.dart';
import 'package:fitr/globals.dart' as globals;
import 'package:http/http.dart' as http;

class WorkoutDetailPage extends StatefulWidget {
  final User user;
  final Workout workout;

  WorkoutDetailPage(this.user, {this.workout, Key key}) : super(key: key);

  @override
  _WorkoutDetailPageState createState() => _WorkoutDetailPageState();
}

class _WorkoutDetailPageState extends State<WorkoutDetailPage> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  WorkoutDetail _workoutDetail;

  @override
  void initState() {
    super.initState();

    fetchWorkoutDetails().then((value) => {
          setState(() => {_workoutDetail = value})
        });
  }

  Future<WorkoutDetail> fetchWorkoutDetails() async {
    var url = globals.baseApiUrl;

    final response = await http.get('$url/api/workouts/${widget.workout.id}',
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${widget.user.token}'
        });

    if (response.statusCode == 401) logout();

    WorkoutDetail workout = WorkoutDetail.fromJson(json.decode(response.body));

    return response.statusCode == 200 ? workout : null;
  }

  void logout() {
    Navigator.pushNamedAndRemoveUntil(context, "/login", (r) => false);
  }

  getExercises() {
    var exercises = new List<Widget>();

    if (_workoutDetail.exercises != null &&
        _workoutDetail.exercises.length > 0) {
      for (var exercise in _workoutDetail.exercises) {
        exercises.add(new ExerciseCard(exercise));
      }
    } else {
      return new Text('No exercises yet ...');
    }

    return exercises;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: globals.primaryColor,
        key: _drawerKey,
        drawer: SideMenu(widget.user),
        floatingActionButton: FloatingActionButton(
          backgroundColor: globals.primaryColor,
          foregroundColor: globals.infoColor,
          child: Icon(Icons.menu),
          onPressed: () => _drawerKey.currentState.openDrawer(),
        ),
        bottomNavigationBar: BottomAppBar(
            color: globals.secondaryColor, child: Container(height: 60)),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: SafeArea(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 57, left: 18),
                          child: Text(
                              (_workoutDetail != null)
                                  ? _workoutDetail.name
                                  : 'Workout',
                              style: TextStyle(
                                  color: globals.primaryTextColor,
                                  fontSize: 36,
                                  fontWeight: FontWeight.w900,
                                  fontStyle: FontStyle.normal,
                                  letterSpacing: 0.5)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18),
                          child: Text(
                              (_workoutDetail != null)
                                  ? '${_workoutDetail.exercises.length.toString()} exercises'
                                  : 'Loading exercises',
                              style: TextStyle(
                                color: globals.secondaryTextColor,
                                fontSize: 17,
                              )),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 57.0),
                      child: Row(
                        children: <Widget>[
                          Text('Active',
                              style: TextStyle(
                                  color: globals.secondaryTextColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  letterSpacing: 0.5)),
                          Switch(
                            value: (_workoutDetail != null)
                                ? _workoutDetail.isActive
                                : false,
                            onChanged: (value) {},
                            activeTrackColor: globals.secondaryTextColor,
                            activeColor: globals.infoColor,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                FutureBuilder(
                    future: fetchWorkoutDetails(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Expanded(
                            child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Container(
                                  child: ListView(
                                    children: getExercises(),
                                    scrollDirection: Axis.horizontal,
                                  ),
                                )));
                      } else {
                        return Container(
                            child: Expanded(
                                child: Center(
                                    child: CircularProgressIndicator())));
                      }
                    }),
                Padding(
                  padding: const EdgeInsets.only(bottom: 45.0),
                  child: Center(
                      child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        print('Card tapped.');
                      },
                      child: Container(
                        width: 360,
                        height: 70,
                        child: Center(
                          child: Text('Start workout',
                              style: TextStyle(
                                  color: globals.primaryTextColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1)),
                        ),
                      ),
                    ),
                  )),
                )
              ],
            ),
          ),
        ));
  }
}
