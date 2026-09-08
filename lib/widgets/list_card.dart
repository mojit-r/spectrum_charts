import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spectrum_charts/providers/chart_provider.dart';
import 'package:spectrum_charts/widgets/highlighted_text.dart';

class ListCard extends StatelessWidget {
  final int chartNumber;
  final String chartName;

  const ListCard({
    super.key,
    required this.chartNumber,
    required this.chartName,
  });

  @override
  Widget build(BuildContext context) {
    final chartText = '$chartNumber - $chartName';

    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: ListTile(
          leading: const Icon(Icons.sticky_note_2_outlined),
          title: Selector<ChartProvider, String>(
            selector: (context, provider) => provider.searchedQuery,
            builder: (context, searchedQuery, _) => HighlightedText(
              text: chartText,
              query: searchedQuery,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
