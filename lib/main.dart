import 'package:flutter/material.dart';
import 'package:plant_disease_frontend/screens/my_home_page.dart';
import 'screens/my_home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: 'Plant Disease Recognizer'),
    );
  }
}