
class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double y;
}
class Temperature {
  final int value;
  final String date;

  const Temperature({
    required this.value,
    required this.date,
  });

  factory Temperature.fromJson(Map<String, dynamic> json) {
    return Temperature(
      value: json['value'],
      date: json['date'],
    );
  }
}
