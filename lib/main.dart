import 'package:fitr/components/login-form.dart';
import 'package:fitr/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(FitrApp());

class FitrApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FitrAppState();
  }
}

class FitrAppState extends State<FitrApp> {
  final _routes = {
    '/dashboard': (context) => HomePage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Fitr',
        theme: ThemeData(fontFamily: 'Roboto'),
        routes: _routes,
        home: LoginForm());
  }
}
