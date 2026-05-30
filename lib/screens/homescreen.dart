import 'package:flutter/material.dart';
import 'package:spectrum_charts/widgets/custom_search_bar.dart';
import '../model/chart.dart';
import '../provider/search_provider.dart';
import '../widgets/list_card.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  late Future<List<Chart>> chartsFuture;

  @override
  void initState() {
    super.initState();
    chartsFuture = loadJson();
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = context.watch<SearchProvider>();
    return Scaffold(
      appBar: AppBar(
        title: searchProvider.isSearching
            ? const SizedBox(height: 42, child: CustomSearchBar())
            : Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Image.asset('assets/icon/app_icon.png', height: 200),
              ),
        elevation: 12,
        toolbarHeight: 70,
        titleSpacing: 2,
        // centerTitle: true,
        leading: searchProvider.isSearching
            ? IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search_rounded, size: 30),
              )
            : null,
        actions: [
          IconButton(
            icon: searchProvider.isSearching
                ? const Icon(Icons.close, size: 30)
                : const Icon(Icons.search_rounded, size: 30),

            onPressed: searchProvider.isSearching
                ? () {
                    searchProvider.stopSearching();
                  }
                : () {
                    searchProvider.setIsSearching();
                  },
          ),
        ],
      ),
      body: FutureBuilder<List<Chart>>(
        future: chartsFuture,
        builder: (context, snapshot) {
          // ⏳ Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // ❌ Error
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // ⚠️ No data
          if (!snapshot.hasData) {
            return const Center(child: Text('No data found'));
          }

          final charts = snapshot.data!;
          return ListView.builder(
            itemCount: charts.length,
            // itemExtent: 56,
            // cacheExtent: 300,
            itemBuilder: (context, index) {
              final chart = charts[index];

              return ListCard(
                key: ValueKey(chart.chartName),
                chartNumber: chart.chartNumber,
                chartName: chart.chartName,
              );
            },
          );
        },
      ),
    );
  }
}
