import 'package:bz_quiz/components/common/app-bar.dart';
import 'package:bz_quiz/components/common/backgroung_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:soundpool/soundpool.dart';

import 'result.dart';

class PlayQuiz extends StatefulWidget {
  final int index;
  final int level;
  PlayQuiz({this.index, this.level});
  @override
  _PlayQuizState createState() => _PlayQuizState();
}

class _PlayQuizState extends State<PlayQuiz> with SingleTickerProviderStateMixin {
  final Firestore _firestore = Firestore.instance;
  int _finalScore = 0;
  int _questionNumber = 1;
  int _questionIndex = 0;
  var quiz;
  final Soundpool _soundpool = Soundpool(streamType: StreamType.notification);

  Widget _question(String content) {
    return Card(
      color: Colors.grey[800],
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
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

  void _showCorrectToast() {
    Fluttertoast.showToast(
      msg: "正解です",
      fontSize: 20.0,
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.indigoAccent,
    );
  }

  void _showIncorrectToast() {
    Fluttertoast.showToast(
      msg: "不正解です",
      fontSize: 20.0,
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.redAccent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      transitionBuilder: (child, animation) {
        final _offsetAnimation = Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0)).animate(animation);
        return SlideTransition(child: child, position: _offsetAnimation);
      },
      child: StreamBuilder<QuerySnapshot>(
        key: ValueKey<int>(_questionIndex),
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
      ),
    );
  }

  void _updateQuestion(BuildContext context) {
    setState(() {
      if (_questionNumber == 5) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Result(score: _finalScore),
            ),
            (_) => false);
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
        _playCorrectSound();
        _finalScore++;
      }
    });
    if (answer == quiz['correct']) {
      _showCorrectToast();
    } else {
      _playIncorrectSound();
      _showIncorrectToast();
    }
  }

  Future _playCorrectSound() async {
    int soundId = await rootBundle.load("assets/sounds/correct_answer.mp3").then((ByteData soundData) {
      return _soundpool.load(soundData);
    });
    await _soundpool.play(soundId);
  }

  Future _playIncorrectSound() async {
    int soundId = await rootBundle.load("assets/sounds/incorrect_answer.mp3").then((ByteData soundData) {
      return _soundpool.load(soundData);
    });
    await _soundpool.play(soundId);
  }
}
