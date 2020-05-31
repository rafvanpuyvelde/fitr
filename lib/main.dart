import 'package:fitr/components/login-form.dart';
import 'package:fitr/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fitr/globals.dart' as globals;

void main() => runApp(FitrApp());

class FitrApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FitrAppState();
  }
}

class FitrAppState extends State<FitrApp> {
  final _routes = {
    '/dashboard': (context) => DashboardPage(),
    '/login': (context) => LoginForm(),
  };

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: globals.primaryColor,
        statusBarIconBrightness: Brightness.dark));

    return MaterialApp(
        title: 'Fitr',
        theme: ThemeData(fontFamily: 'Roboto'),
        routes: _routes,
        home: LoginForm());
  }
}
