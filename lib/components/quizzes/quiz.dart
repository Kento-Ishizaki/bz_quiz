import 'package:bz_quiz/components/common/app-bar.dart';
import 'package:bz_quiz/components/common/backgroung_image.dart';
import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  Widget _question() {
    return Card(
      color: Colors.grey[800],
      child: Container(
        height: 100.0,
        child: Center(
          child: Text(
            'Q1. 稲葉さんの生年月日は？',
            textScaleFactor: 1.2,
          ),
        ),
      ),
    );
  }

  Widget _options() {
    return Card(
      color: Colors.grey[600],
      child: Container(
        height: 50.0,
        child: Center(
          child: Text(
            'hogehoge',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('クイズ'),
      body: Container(
        decoration: backgroundImage(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              _question(),
              Spacer(flex: 2),
              _options(),
              _options(),
              _options(),
              _options(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
