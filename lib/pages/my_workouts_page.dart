import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fitr/models/album.dart';
import 'package:flutter/material.dart';

Future<List<Album>> fetchAlbums() async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/albums');

  List<Album> albums = (json.decode(response.body) as List)
      .map((i) => Album.fromJson(i))
      .toList();

  if (response.statusCode != 200) throw Exception('Failed to load album');

  return albums;
}

class MyWorkoutsPage extends StatefulWidget {
  MyWorkoutsPage({Key key}) : super(key: key);

  @override
  _MyWorkoutsPageState createState() => _MyWorkoutsPageState();
}

class _MyWorkoutsPageState extends State<MyWorkoutsPage> {
  Future<List<Album>> _futureAlbums;

  @override
  void initState() {
    super.initState();
    _futureAlbums = fetchAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 15, 15, 15),
      child: Column(
        children: <Widget>[
          Text('My workouts',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 254),
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.5)),
          Expanded(
              child: FutureBuilder(
                  future: _futureAlbums,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return Container(
                          child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Text(
                                  '${snapshot.data[index].title}',
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 255, 255, 254)),
                                );
                              }));
                    }
                  })),
        ],
      ),
    );
  }
}
