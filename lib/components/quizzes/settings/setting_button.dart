import 'package:bz_quiz/components/quizzes/settings/index_quiz.dart';
import 'package:flutter/material.dart';

class SettingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SizedBox(
          width: 250.0,
          height: 100.0,
          child: RaisedButton(
            color: Colors.indigo,
            child: Text(
              '設定',
              textScaleFactor: 1.4,
            ),
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IndexQuizPage(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
