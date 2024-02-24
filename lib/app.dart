import 'package:flutter/material.dart';
import 'package:tube_organize/core/color_scheme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tube Organize',
      theme: ThemeData(
        colorScheme: lightColorScheme,
        useMaterial3: true,
      ),
      darkTheme:  ThemeData(
        colorScheme: darkColorScheme,
        useMaterial3: true,
      ),
      home: const Scaffold(),
    );
  }
}