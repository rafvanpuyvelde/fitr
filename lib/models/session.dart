class Session {
  int id;
  DateTime date;
  int workoutId;

  Session({this.id, this.date, this.workoutId});

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['id'],
      date: json['date'],
      workoutId: json['workoutId'],
    );
  }
}
