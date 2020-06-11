import 'package:fitr/components/side-menu.dart';
import 'package:fitr/models/user.dart';
import 'package:flutter/material.dart';
import 'package:fitr/globals.dart' as globals;

class StatisticsPage extends StatefulWidget {
  final User user;

  const StatisticsPage(this.user, {Key key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(25.0),
        child: Scaffold(
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
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            body: SafeArea(child: Center(child: Text('Statistics WIP')))));
  }
}
