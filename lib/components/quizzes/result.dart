import 'package:bz_quiz/components/common/app-bar.dart';
import 'package:bz_quiz/components/common/backgroung_image.dart';
import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int score;
  Result({Key key, @required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('結果'),
      body: Container(
        decoration: backgroundImage(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: Card(
              child: Container(
                height: 100.0,
                child: Center(
                  child: Text(
                    'あなたの正解数は$score/5でした',
                    textScaleFactor: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
