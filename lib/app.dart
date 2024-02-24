import 'package:flutter/material.dart';
import 'package:tube_organize/core/color_scheme.dart';
import 'package:tube_organize/views/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tube Organize',
      theme: ThemeData(
        colorScheme: lightColorScheme,
        useMaterial3: true,
      ),
      darkTheme:  ThemeData(
        colorScheme: darkColorScheme,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}