import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:spectrum_charts/widgets/custom_search_bar.dart';

import '../providers/chart_provider.dart';
import '../widgets/list_card.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  DateTime? _lastBackPressed;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ChartProvider>().loadCharts();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chartProvider = context.watch<ChartProvider>();
    return Scaffold(
      appBar: AppBar(
        title: AnimatedCrossFade(
          duration: const Duration(milliseconds: 450),
          firstChild: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Image.asset('assets/icon/app_icon.png', height: 200),
          ),
          secondChild: SizedBox(
            height: 42,
            child: CustomSearchBar(
              controller: _searchController,
              onChanged: (value) {
                context.read<ChartProvider>().filterCharts(value);
              },
            ),
          ),
          crossFadeState: chartProvider.isSearching
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
        ),
        elevation: 12,
        toolbarHeight: 70,
        titleSpacing: 2,
        // centerTitle: true,
        leading: chartProvider.isSearching
            ? IconButton(
                onPressed: () {
                  chartProvider.stopSearching();
                  _searchController.clear();
                },
                icon: const Icon(Icons.arrow_back, size: 30),
              )
            : null,
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded, size: 30),
            onPressed: chartProvider.isSearching
                ? () {}
                : () {
                    chartProvider.setIsSearching();
                  },
          ),
        ],
      ),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (chartProvider.isSearching) {
            chartProvider.stopSearching();
            _searchController.clear();
            return;
          }

          final now = DateTime.now();

          if (_lastBackPressed == null ||
              now.difference(_lastBackPressed!) > const Duration(seconds: 2)) {
            _lastBackPressed = now;

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.grey[850],
                behavior: SnackBarBehavior.floating,
                duration: const Duration(milliseconds: 1800),
                content: const Text('Tap again to exit'),
              ),
            );
            return;
          }

          SystemNavigator.pop();
        },
        child: Scrollbar(
          controller: _scrollController,
          thumbVisibility: true,
          child: ListView.builder(
            controller: _scrollController,
            itemCount: chartProvider.filteredCharts.length,
            // itemExtent: 56,
            // cacheExtent: 300,
            itemBuilder: (context, index) {
              final chart = chartProvider.filteredCharts[index];
          
              return ListCard(
                key: ValueKey(chart.chartName),
                chartNumber: chart.chartNumber,
                chartName: chart.chartName,
              );
            },
          ),
        ),
      ),
    );
  }
}
