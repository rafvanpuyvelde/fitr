import 'dart:convert';
import 'package:fitr/components/exercise-session-table.dart';
import 'package:fitr/components/side-menu.dart';
import 'package:fitr/models/user.dart';
import 'package:fitr/models/workout_detail_exercise.dart';
import 'package:fitr/models/workout_exercise_session_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fitr/globals.dart' as globals;
import 'package:http/http.dart' as http;

class ExerciseDetailPage extends StatefulWidget {
  final ExerciseDetail exercise;
  final User user;
  final int workoutId;
  final String workoutName;

  ExerciseDetailPage(this.exercise, this.user, this.workoutId, this.workoutName,
      {Key key})
      : super(key: key);

  @override
  _ExerciseDetailPageState createState() => _ExerciseDetailPageState();
}

class _ExerciseDetailPageState extends State<ExerciseDetailPage> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

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
                        child: Text(widget.exercise.name,
                            style: TextStyle(
                                color: globals.primaryTextColor,
                                fontSize: 36,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.normal,
                                letterSpacing: 0.5)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: Text(widget.workoutName,
                            style: TextStyle(
                              color: globals.secondaryTextColor,
                              fontSize: 17,
                            )),
                      ),
                    ],
                  )
                ],
              ),
              FutureBuilder(
                  future: fetchExerciseSessionDetail(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ExerciseSessionTable(snapshot.data);
                    } else {
                      return Container(
                          child: Expanded(
                              child:
                                  Center(child: CircularProgressIndicator())));
                    }
                  })
            ],
          ),
        ));
  }

  Future<WorkoutExerciseSessionDetail> fetchExerciseSessionDetail() async {
    var url = globals.baseApiUrl;

    final response = await http.get(
        '$url/api/workouts/${widget.workoutId}/exercises/${widget.exercise.id}/sessions',
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${widget.user.token}'
        });

    if (response.statusCode == 401) logout();

    WorkoutExerciseSessionDetail workouts =
        WorkoutExerciseSessionDetail.fromJson(json.decode(response.body));

    return response.statusCode == 200 ? workouts : null;
  }

  void logout() {
    Navigator.pushNamedAndRemoveUntil(context, "/login", (r) => false);
  }
}
