import 'dart:async';
import 'dart:convert';
import 'package:fitr/components/side-menu.dart';
import 'package:fitr/models/user.dart';
import 'package:fitr/models/workout.dart';
import 'package:fitr/pages/workout_detail_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fitr/globals.dart' as globals;

class MyWorkoutsPage extends StatefulWidget {
  final User user;

  MyWorkoutsPage(this.user, {Key key}) : super(key: key);

  @override
  _MyWorkoutsPageState createState() => _MyWorkoutsPageState();
}

class _MyWorkoutsPageState extends State<MyWorkoutsPage> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  Future<List<Workout>> _futureWorkouts;

  Future<List<Workout>> fetchWorkouts() async {
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

    return response.statusCode == 200 ? workouts : null;
  }

  void logout() {
    Navigator.pushNamedAndRemoveUntil(context, "/login", (r) => false);
  }

  onWorkoutTapped(Workout workout) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                WorkoutDetailPage(widget.user, workout: workout)));
  }

  @override
  void initState() {
    super.initState();
    _futureWorkouts = fetchWorkouts();
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
                padding: const EdgeInsets.only(top: 57, left: 18, bottom: 33),
                child: Text('My Workouts',
                    style: TextStyle(
                        color: globals.primaryTextColor,
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'Roboto',
                        letterSpacing: 0.5)),
              ),
              Expanded(
                  child: FutureBuilder(
                      future: _futureWorkouts,
                      builder: (context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return Container(
                              child: ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 8, left: 18, right: 18),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  onWorkoutTapped(
                                                      snapshot.data[index]);
                                                },
                                                child: Container(
                                                    height: 60,
                                                    color:
                                                        globals.secondaryColor,
                                                    child: Container(
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 31),
                                                            child: Text(
                                                              '${snapshot.data[index].name}',
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          48,
                                                                          57,
                                                                          71),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                  fontSize: 16,
                                                                  letterSpacing:
                                                                      0.2),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 20),
                                                            child: Icon(
                                                                Icons
                                                                    .fiber_manual_record,
                                                                color: snapshot
                                                                        .data[
                                                                            index]
                                                                        .isActive
                                                                    ? globals
                                                                        .infoColor
                                                                    : Colors
                                                                        .transparent),
                                                          )
                                                        ],
                                                      ),
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }));
                        }
                      })),
            ],
          ),
        )));
  }
}
