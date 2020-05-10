import 'package:fitr/models/user.dart';
import 'package:fitr/pages/dashboard_page.dart';
import 'package:fitr/pages/my_workouts_page.dart';
import 'package:fitr/pages/settings_page.dart';
import 'package:fitr/pages/statistics_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fitr/globals.dart' as globals;

class MenuItem extends StatefulWidget {
  final String text;
  final User user;

  MenuItem(this.text, this.user, {Key key}) : super(key: key);

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          widget.text,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: globals.primaryTextColor),
        ),
        onTap: () {
          Navigator.pop(context);

          switch (widget.text) {
            case 'Dashboard':
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      DashboardPage(user: widget.user)));
              break;
            case 'Statistics':
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      StatisticsPage(widget.user)));
              break;
            case 'Workouts':
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      MyWorkoutsPage(widget.user)));
              break;
            case 'Settings':
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      SettingsPage(widget.user)));
              break;
            default:
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      DashboardPage(user: widget.user)));
              break;
          }
        });
  }
}
