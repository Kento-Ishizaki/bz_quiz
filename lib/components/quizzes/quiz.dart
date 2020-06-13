import 'package:bz_quiz/components/common/app-bar.dart';
import 'package:bz_quiz/components/common/backgroung_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'result.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  final Firestore _firestore = Firestore.instance;
  int _finalScore = 0;
  int _questionNumber = 1;
  int _questionIndex = 0;
  var quiz;

  Widget _question(String content) {
    return Card(
      color: Colors.grey[800],
      child: Container(
        height: 100.0,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Q$_questionNumber.',
                textScaleFactor: 1.2,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                content,
                textScaleFactor: 1.2,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _choiceButton(String content, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Card(
        color: Colors.grey[700],
        child: InkWell(
          splashColor: Colors.white.withAlpha(100),
          onTap: () {
            _updateQuestion(context);
            _checkAnswer(content);
          },
          child: Container(
            height: 50.0,
            child: Center(
              child: Text(
                content,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      // Firestoreからデータを取得
      // TODO ランダムに取得したい
      stream: _firestore.collection('quizzes').where('level', isEqualTo: 1).limit(5).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('データの取得に失敗しました ${snapshot.error}'),
          );
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            quiz = snapshot.data.documents[_questionIndex];
            String _correctAnswer = quiz['correct'];
            return Scaffold(
              appBar: appBar('クイズ'),
              body: Container(
                decoration: backgroundImage(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Spacer(),
                      _question(quiz['question']),
                      Spacer(flex: 2),
                      _choiceButton(quiz['option1'], context),
                      _choiceButton(quiz['option2'], context),
                      _choiceButton(quiz['option3'], context),
                      _choiceButton(quiz['option4'], context),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            );
        }
      },
    );
  }

  void _updateQuestion(BuildContext context) {
    setState(() {
      if (_questionNumber == 5) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Result(score: _finalScore),
          ),
        );
      } else {
        _questionNumber++;
        _questionIndex++;
      }
    });
  }

  void _checkAnswer(String answer) {
    print(quiz['correct']);
    setState(() {
      if (answer == quiz['correct']) {
        _finalScore++;
      }
    });
  }
}
