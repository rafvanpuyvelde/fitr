import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  final Widget child;

  BasePage({Key key, @required this.child}) : super(key: key);

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 15, 15, 15),
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
          backgroundColor: Color.fromARGB(255, 29, 29, 29)
      ),
      body: SafeArea(
        child: widget.child
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Dashboard'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Statistics'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('Workouts'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('Settings'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped
      ),
    );
  }
}
