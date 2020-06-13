import 'package:bz_quiz/components/common/app-bar.dart';
import 'package:bz_quiz/components/common/backgroung_image.dart';
import 'package:bz_quiz/components/quizzes/level.dart';
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
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
                Container(
                  height: 70.0,
                  margin: EdgeInsets.only(top: 50.0),
                  child: RaisedButton(
                    child: Text(
                      'レベル選択画面に戻る',
                      textScaleFactor: 1.2,
                    ),
                    onPressed: () {
                      _resetQuiz(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _resetQuiz(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Level()),
    );
  }
}
