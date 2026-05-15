import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(right: 8.0),
      child: TextField(
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          label: Text('Search'),
          icon: Icon(Icons.search_rounded),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}