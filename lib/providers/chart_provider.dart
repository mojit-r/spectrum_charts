import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:spectrum_charts/model/chart.dart';

class ChartProvider extends ChangeNotifier {
  List<Chart> _allCharts = [];
  List<Chart> _filteredCharts = [];

  List<Chart> get filteredCharts => _filteredCharts;

  String _searchedQuery = '';
  String get searchedQuery => _searchedQuery;

  bool _isSearching = false;
  bool get isSearching => _isSearching;

  Future<void> loadCharts() async {
    final jsonString = await rootBundle.loadString(
      'assets/data/spectrum_charts_101_810.json',
    );
    final List<dynamic> jsonData = await compute(parseJson, jsonString);

    _allCharts = jsonData.map((e) => Chart.fromJson(e)).toList();
    _filteredCharts = List.from(_allCharts);
    notifyListeners();
  }

  void filterCharts(String query) {
    _searchedQuery = query;
    if (query.isEmpty) {
      _filteredCharts = List.from(_allCharts);
    } else {
      _filteredCharts = _allCharts.where((chart) {
        return chart.chartName.toLowerCase().contains(query.toLowerCase()) ||
            chart.chartNumber.toString().contains(query);
      }).toList();
    }
    notifyListeners();
  }

  void setIsSearching() {
    _isSearching = true;
    notifyListeners();
  }

  void stopSearching() {
    _isSearching = false;
    _filteredCharts = List.from(_allCharts);
    _searchedQuery = '';
    notifyListeners();
  }
}
