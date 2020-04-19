import 'dart:async';
import 'dart:convert';
import 'package:fitr/models/user.dart';
import 'package:fitr/models/workout.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class MyWorkoutsPage extends StatefulWidget {
  final User user;

  MyWorkoutsPage({this.user, Key key}) : super(key: key);

  @override
  _MyWorkoutsPageState createState() => _MyWorkoutsPageState();
}

class _MyWorkoutsPageState extends State<MyWorkoutsPage> {
  Future<List<Workout>> _futureWorkouts;

  Future<List<Workout>> fetchWorkouts() async {
    const url = 'http://758e99bd.ngrok.io';

    final response =
        await http.get('$url/api/workouts', headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${widget.user.token}'
    });

    List<Workout> workouts = (json.decode(response.body) as List)
        .map((i) => Workout.fromJson(i))
        .toList();

    return response.statusCode == 200 ? workouts : null;
  }

  @override
  void initState() {
    super.initState();
    _futureWorkouts = fetchWorkouts();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 15, 15, 15),
      child: Column(
        children: <Widget>[
          Text('My workouts',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 254),
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.5)),
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
                              itemBuilder: (BuildContext context, int index) {
                                return Text(
                                  '${snapshot.data[index].name}',
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 255, 255, 254)),
                                );
                              }));
                    }
                  })),
        ],
      ),
    );
  }
}
