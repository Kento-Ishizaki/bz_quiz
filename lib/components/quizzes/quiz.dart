import 'package:bz_quiz/components/common/app-bar.dart';
import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('クイズ'),
      body: Center(
        child: Text('クイズ回答画面'),
      ),
    );
  }
}
