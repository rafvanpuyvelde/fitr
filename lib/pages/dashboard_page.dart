import 'package:fitr/models/user.dart';
import 'package:flutter/material.dart';
import 'package:fitr/globals.dart' as globals;

class DashboardPage extends StatefulWidget {
  final User user;

  DashboardPage({this.user, Key key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    double itemHeight = (MediaQuery.of(context).size.height - 120) / 2;
    double itemWidth = (MediaQuery.of(context).size.width) / 2;

    return SafeArea(
      child: Container(
        color: globals.primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 30),
              child: Text('Welcome ${widget.user.name}',
                  style: TextStyle(
                      color: globals.primaryTextColor,
                      decoration: TextDecoration.none,
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.normal,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5)),
            ),
            Expanded(
                child: GridView.count(
                    primary: false,
                    padding:
                        const EdgeInsets.only(left: 23, right: 23, top: 40),
                    childAspectRatio: (itemWidth / itemHeight),
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    crossAxisCount: 2,
                    children: getGridControls()))
          ],
        ),
      ),
    );
  }

  List<Widget> getGridControls() {
    var controls = List<Widget>();

    var icons = [Icons.show_chart, Icons.fitness_center, Icons.settings];
    var controlHelperTextList = ['Show', 'Show', 'Edit'];
    var controlMainTextList = ['Statistics', 'Workouts', 'Settings'];

    for (var i = 0; i < controlMainTextList.length; i++) {
      controls.add(
        new ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Icon(icons[i],
                      color: globals.primaryTextColor, size: 45.0),
                ),
                Text(controlHelperTextList[i],
                    style: TextStyle(
                        color: globals.secondaryTextColor,
                        decoration: TextDecoration.none,
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500)),
                Text(controlMainTextList[i],
                    style: TextStyle(
                        color: globals.primaryTextColor,
                        decoration: TextDecoration.none,
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w900))
              ],
            ),
            color: globals.secondaryColor,
          ),
        ),
      );
    }

    addStartControl(controls);

    return controls;
  }

  void addStartControl(List<Widget> controls) {
    controls.add(
      new Container(
          decoration: BoxDecoration(
              color: globals.secondaryColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 2, color: globals.primaryTextColor)),
          padding: const EdgeInsets.all(22),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                getStartIcon(),
                Text('Start',
                    style: TextStyle(
                        color: globals.primaryTextColor,
                        decoration: TextDecoration.none,
                        fontSize: 22,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w900)),
                Text('Workout',
                    style: TextStyle(
                        color: globals.secondaryTextColor,
                        decoration: TextDecoration.none,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400))
              ],
            ),
          )),
    );
  }

  ShaderMask getStartIcon() {
    return ShaderMask(
      shaderCallback: (bounds) => RadialGradient(
        center: Alignment.topLeft,
        radius: 0.55,
        colors: [
          Color.fromARGB(255, 189, 79, 191),
          Color.fromARGB(255, 244, 176, 192)
        ],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: Icon(Icons.play_arrow, size: 70.0, color: Colors.white),
    );
  }
}
