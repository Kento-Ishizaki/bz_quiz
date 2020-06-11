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
        accentColor: Colors.red,
        primaryColorDark: Colors.indigo,
        buttonColor: Colors.red[900].withOpacity(0.6),
      ),
      home: Home(),
    );
  }
}
