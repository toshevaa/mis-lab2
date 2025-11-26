import 'package:flutter/material.dart';
import 'package:mis_lab2/screens/home_screen.dart';
void main() {
  runApp(RecipesApp());
}

class RecipesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipes App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.grey[50],
        textTheme: TextTheme(
        ),
      ),
      home: HomeScreen(),
    );
  }
}
