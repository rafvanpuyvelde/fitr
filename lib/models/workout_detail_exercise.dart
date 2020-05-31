class ExerciseDetail {
  int id;
  String name;
  String unit;
  double record;
  double trend;

  ExerciseDetail({this.id, this.name, this.unit, this.record, this.trend});

  factory ExerciseDetail.fromJson(Map<String, dynamic> json) {
    return ExerciseDetail(
        id: json['id'],
        name: json['name'],
        unit: json['unit'],
        record: json['record'].toDouble(),
        trend: json['trend']);
  }
}
