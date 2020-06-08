import 'package:bz_quiz/components/home/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'B\'z Quiz',
      theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.cyan,
        primaryColorDark: Colors.indigo,
      ),
      home: Home(),
    );
  }
}
