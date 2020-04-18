import 'package:fitr/models/workout.dart';

class User {
  String id;
  String name;
  String lastName;
  String username;
  String email;
  String password;
  DateTime createdOn;
  List<Workout> workouts;
  String token;

  User(
      {this.id,
      this.name,
      this.lastName,
      this.username,
      this.email,
      this.password,
      this.createdOn,
      this.workouts,
      this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        lastName: json['lastName'],
        username: json['userName'],
        email: json['email'],
        password: json['password'],
        createdOn: json['createdOn'] != null
            ? DateTime.parse(json['createdOn'])
            : null,
        workouts: json['workouts'],
        token: json['token']);
  }
}
