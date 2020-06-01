import 'package:fitr/components/side-menu.dart';
import 'package:fitr/models/user.dart';
import 'package:fitr/models/workout_detail_exercise.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fitr/globals.dart' as globals;

class ExerciseDetailPage extends StatefulWidget {
  final ExerciseDetail exercise;
  final User user;

  ExerciseDetailPage(this.exercise, this.user, {Key key}) : super(key: key);

  @override
  _ExerciseDetailPageState createState() => _ExerciseDetailPageState();
}

class _ExerciseDetailPageState extends State<ExerciseDetailPage> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  var gradientColors = [
    const Color.fromARGB(255, 146, 44, 249),
    globals.primaryColor //     const Color.fromARGB(255, 249, 178, 191),
  ];

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 57, left: 18),
                        child: Text('Bench press',
                            style: TextStyle(
                                color: globals.primaryTextColor,
                                fontSize: 36,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.normal,
                                letterSpacing: 0.5)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: Text('Full body workout',
                            style: TextStyle(
                              color: globals.secondaryTextColor,
                              fontSize: 17,
                            )),
                      ),
                    ],
                  )
                ],
              ),
              Stack(children: <Widget>[
                AspectRatio(
                  aspectRatio: 1.70,
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                      Radius.circular(18),
                    )),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 0, left: 0, top: 0, bottom: 0),
                      child: LineChart(
                        mainData(),
                      ),
                    ),
                  ),
                )
              ]),
            ],
          ),
        ));
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(show: false, drawVerticalLine: false),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: false,
          reservedSize: 22,
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: false,
          reservedSize: 28,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 10,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.5)).toList(),
          ),
        ),
      ],
    );
  }
}
