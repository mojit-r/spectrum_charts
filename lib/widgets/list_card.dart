import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spectrum_charts/providers/chart_provider.dart';

class ListCard extends StatelessWidget {
  final int chartNumber;
  final String chartName;

  const ListCard({
    super.key,
    required this.chartNumber,
    required this.chartName,
  });

  List<TextSpan> _highlightSpans(String text, String query, BuildContext context) {
    if (query.isEmpty) {
      return [
        TextSpan(
          text: text,
          style: const TextStyle(color: Colors.black),
        ),
      ];
    }

    final lowerCaseText = text.toLowerCase();
    final lowerCaseQuery = query.toLowerCase();
    final matchIndex = lowerCaseText.indexOf(lowerCaseQuery);

    if (matchIndex == -1) {
      return [
        TextSpan(
          text: text,
          style: const TextStyle(color: Colors.black),
        ),
      ];
    }

    // Split text into pre-match, matched and post-matched
    final String beforeMatch = text.substring(0, matchIndex);
    final String matchedText = text.substring(
      matchIndex,
      matchIndex + query.length,
    );
    final String afterMatch = text.substring(matchIndex + query.length);

    return [
      TextSpan(
        text: beforeMatch,
        style: const TextStyle(color: Colors.black),
      ),
      TextSpan(
        text: matchedText,
        style: TextStyle(
          color: Colors.black,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      TextSpan(
        text: afterMatch,
        style: const TextStyle(color: Colors.black),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final String chartText = '$chartNumber - $chartName';
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: ListTile(
          leading: const Icon(Icons.sticky_note_2_outlined),
          title: Selector<ChartProvider, String>(
            selector: (context, value) => value.searchedQuery,
            builder: (context, searchedQuery, child) => RichText(
              text: TextSpan(
                children: _highlightSpans(chartText, searchedQuery, context),
                style: const TextStyle(fontSize: 16)
              ),
            ),
          ),
        ),
      ),
    );
  }
}
