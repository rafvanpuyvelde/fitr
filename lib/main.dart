import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'pages/my_workouts_page.dart';

void main() => runApp(FitrApp());

class FitrApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitr',
      theme: ThemeData(fontFamily: 'Roboto'),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        '/my-workouts': (BuildContext context) => MyWorkouts(),
      },
    );
  }
}