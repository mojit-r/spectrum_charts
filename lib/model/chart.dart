import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

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

Future<List<Chart>> loadJson() async {
  String jsonString = await rootBundle.loadString(
    'assets/data/spectrum_charts_101_810.json',
  );

  final List<dynamic> jsonData = await compute(parseJson, jsonString);

  return jsonData.map((e) => Chart.fromJson(e)).toList();
}

List<dynamic> parseJson(String response) {
  return json.decode(response);
}