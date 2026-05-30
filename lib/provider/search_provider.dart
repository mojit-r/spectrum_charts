import 'package:flutter/material.dart';
import 'package:spectrum_charts/model/chart.dart';

class SearchProvider extends ChangeNotifier {
  List<Chart> _filteredCharts = [];

  List<Chart> get filteredCharts => _filteredCharts;

  bool isSearching = false;

  void setIsSearching() {
    isSearching = true;
    notifyListeners();
  }

  void stopSearching() {
    isSearching = false;
    notifyListeners();
  }
}
