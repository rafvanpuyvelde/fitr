import 'package:fitr/models/workout_exercise_session_detail.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExerciseSessionGraph extends StatefulWidget {
  final WorkoutExerciseSessionDetail sessionData;

  ExerciseSessionGraph(this.sessionData, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ExerciseSessionGraphState();
}

class ExerciseSessionGraphState extends State<ExerciseSessionGraph> {
  final Color leftBarColor = const Color.fromARGB(255, 249, 178, 191);
  final Color rightBarColor = const Color.fromARGB(255, 146, 44, 249);

  final double width = 7;

  List<BarChartGroupData> rawBarGroups;
  List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex;

  List<BarChartGroupData> getGraphData() {
    var sessionCounter = 0;
    var dataList = new List<BarChartGroupData>();

    widget.sessionData.sessions.forEach((session) {
      var intensity = calculateIntensity(session.reps, session.weight);
      dataList.add(makeGroupData(sessionCounter, intensity));
      sessionCounter++;
    });

    return dataList;
  }

  List<double> calculateIntensity(List<int> reps, List<double> weight) {
    var results = new List<double>();

    for (var measurementIndex = 0;
        measurementIndex < reps.length;
        measurementIndex++) {
      results.add(reps[measurementIndex] * weight[measurementIndex]);
    }

    return results;
  }

  BarChartGroupData makeGroupData(int x, List<double> dataRods) {
    var barRods = new List<BarChartRodData>();

    dataRods.forEach((rod) {
      barRods.add(BarChartRodData(
        y: rod,
        color: rightBarColor,
        width: width,
      ));
    });

    return BarChartGroupData(barsSpace: 4, x: x, barRods: barRods);
  }

  String getTitlesForXaxis(double value) {
    switch (value.toInt()) {
      case 0:
        return 'Mn';
      case 1:
        return 'Te';
      case 2:
        return 'Wd';
      default:
        return '';
    }
  }

  String getTitlesForYaxis(double value) {
    if (value == 0) {
      return '0';
    } else if (value == 500) {
      return '500';
    } else if (value == 1000) {
      return '1K';
    } else {
      return '';
    }
  }

  @override
  void initState() {
    super.initState();

    rawBarGroups = getGraphData();

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: BarChart(
                    BarChartData(
                      maxY: 800,
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: SideTitles(
                          showTitles: true,
                          textStyle: TextStyle(
                              color: const Color(0xff7589a2),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          margin: 20,
                          getTitles: (double value) => getTitlesForXaxis(value),
                        ),
                        leftTitles: SideTitles(
                            showTitles: true,
                            textStyle: TextStyle(
                                color: const Color(0xff7589a2),
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                            margin: 32,
                            reservedSize: 14,
                            getTitles: (value) => getTitlesForYaxis(value)),
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      barGroups: showingBarGroups,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
