import 'package:fitr/components/menu-item.dart';
import 'package:fitr/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fitr/globals.dart' as globals;

class SideMenu extends StatefulWidget {
  static const menuOptions = [
    'Dashboard',
    'Statistics',
    'Workouts',
    'Settings'
  ];

  final User user;

  const SideMenu(this.user, {Key key}) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SafeArea(
            child: Padding(
      padding: const EdgeInsets.only(left: 15.0, top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 35, left: 10, bottom: 30),
            child: Text(
              'Fitr',
              style: TextStyle(
                  color: globals.primaryTextColor,
                  fontSize: 40,
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'Lobster',
                  letterSpacing: 0.5),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 100,
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  MenuItem(SideMenu.menuOptions[0], widget.user),
                  MenuItem(SideMenu.menuOptions[1], widget.user),
                  MenuItem(SideMenu.menuOptions[2], widget.user),
                  MenuItem(SideMenu.menuOptions[3], widget.user)
                ],
              ),
            ),
          )
        ],
      ),
    )));
  }
}
