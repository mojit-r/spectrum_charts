import 'package:flutter/material.dart';
import 'package:spectrum_charts/model/chart.dart';
import 'package:spectrum_charts/widgets/list_card.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/icon/app_icon.png', height: 200),
        elevation: 12,
        toolbarHeight: 70,
        // centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.search_rounded, size: 30), onPressed: () {}),
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