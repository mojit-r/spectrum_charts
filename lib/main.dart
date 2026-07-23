import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spectrum_charts/providers/chart_provider.dart';

import 'package:spectrum_charts/screens/homescreen.dart';
import 'package:spectrum_charts/theme/theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => ChartProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightmode,
      home: const Homescreen(),
    );
  }
}
