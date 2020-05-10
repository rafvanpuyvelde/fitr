import 'package:fitr/models/user.dart';
import 'package:flutter/material.dart';

class StatisticsPage extends StatefulWidget {
  final User user;

  const StatisticsPage(this.user, {Key key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25.0),
      child: Text('Statistics'),
    );
  }
}
