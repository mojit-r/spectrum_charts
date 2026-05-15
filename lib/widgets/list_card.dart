import 'package:flutter/material.dart';

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
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: ListTile(
          leading: const Icon(Icons.sticky_note_2_outlined),
          title: Text('$chartNumber - $chartName'),
        ),
      ),
    );
  }
}
