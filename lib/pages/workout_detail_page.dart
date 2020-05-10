import 'package:fitr/components/side-menu.dart';
import 'package:fitr/models/user.dart';
import 'package:fitr/models/workout.dart';
import 'package:flutter/material.dart';
import 'package:fitr/globals.dart' as globals;

class WorkoutDetailPage extends StatefulWidget {
  final User user;
  final Workout workout;

  WorkoutDetailPage(this.user, {this.workout, Key key}) : super(key: key);

  @override
  _WorkoutDetailPageState createState() => _WorkoutDetailPageState();
}

class _WorkoutDetailPageState extends State<WorkoutDetailPage> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  getExercises() {
    var exercises = new List<Widget>();

    if (widget.workout.exercises != null &&
        widget.workout.exercises.length > 0) {
      for (var exercise in widget.workout.exercises) {
        exercises.add(getExerciseCard(exercise.name));
      }
    } else {
      return new Text('No exercises yet ...');
    }

    return exercises;
  }

  getExerciseCard(String exerciseName) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 30.0, bottom: 30.0, left: 15.0, right: 10.0),
      child: Card(
          child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          print('Card tapped.');
        },
        child: Container(
          width: 300,
          child: Text(exerciseName),
        ),
      )),
    );
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
                Padding(
                  padding: const EdgeInsets.only(top: 57, left: 18),
                  child: Text(widget.workout.name,
                      style: TextStyle(
                          color: globals.primaryTextColor,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Roboto',
                          letterSpacing: 0.5)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Text(
                      '${widget.workout.exercises.length.toString()} exercises',
                      style: TextStyle(
                        color: globals.secondaryTextColor,
                        fontSize: 18,
                      )),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 40),
                  child: Container(
                    child: ListView(
                      children: getExercises(),
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.only(bottom: 70),
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
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
