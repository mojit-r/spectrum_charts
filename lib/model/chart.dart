import 'dart:convert';

class Chart {
  final int chartNumber;
  final String chartName;

  Chart({required this.chartNumber, required this.chartName});

  factory Chart.fromJson(Map<String, dynamic> json) {
    return Chart(
      chartNumber: json['chartNumber'],
      chartName: json['chartName'],
    );
  }
}

List<dynamic> parseJson(String response) {
  return json.decode(response);
}