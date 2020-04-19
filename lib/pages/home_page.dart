import 'package:fitr/models/user.dart';
import 'package:fitr/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:fitr/pages/my_workouts_page.dart';
import 'package:fitr/pages/settings_page.dart';
import 'package:fitr/pages/statistics_page.dart';

class HomePage extends StatefulWidget {
  final User user;

  HomePage({this.user, Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPage = 0;

  final _pageOptions = [
    DashboardPage(),
    StatisticsPage(),
    MyWorkoutsPage(),
    SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              'Fitr',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 254),
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'Lobster',
                  letterSpacing: 0.5),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.account_circle),
                tooltip: 'Show account info',
                onPressed: () {},
              )
            ],
            backgroundColor: Color.fromARGB(255, 29, 29, 29)),
        body: _pageOptions[_selectedPage],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedPage,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Color.fromARGB(255, 29, 29, 29),
            unselectedItemColor: Color.fromARGB(255, 142, 142, 142),
            selectedItemColor: Color.fromARGB(255, 255, 255, 254),
            onTap: (int index) {
              setState(() {
                _selectedPage = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                title: Text('Dashboard'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.timeline),
                title: Text('Statistics'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.fitness_center),
                title: Text('Workouts'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                title: Text('Settings'),
              ),
            ]));
  }
}
