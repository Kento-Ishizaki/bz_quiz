import 'package:bz_quiz/components/common/app-bar.dart';
import 'package:bz_quiz/components/common/backgroung_image.dart';
import 'package:bz_quiz/components/quizzes/plays/result.dart';
import 'package:bz_quiz/providers/quiz_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:soundpool/soundpool.dart';

class PlayQuiz extends StatelessWidget {
  final Soundpool _soundpool = Soundpool(streamType: StreamType.notification);

  Widget _question(String content, int questionNumber) {
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
                'Question ' + questionNumber.toString(),
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

  Widget _choiceButton({String choice, String answer, BuildContext context, dynamic model}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Card(
        color: Colors.grey[700],
        child: InkWell(
          splashColor: Colors.white.withAlpha(100),
          onTap: () async {
            await model.addQuestionNumber();
            _checkAnswer(choice: choice, answer: answer, model: model);
            if (model.questionNumber == 5) {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Result(score: model.finalScore),
                  fullscreenDialog: true,
                ),
              );
            }
          },
          child: Container(
            height: 50.0,
            child: Center(
              child: Text(
                choice,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _checkAnswer({String choice, String answer, dynamic model}) async {
    if (choice == answer) {
      _playCorrectSound();
      _showCorrectToast();
      await model.addFinalScore();
    } else {
      _playIncorrectSound();
      _showIncorrectToast();
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('クイズ'),
      body: Consumer<QuizProvider>(builder: (context, model, child) {
        switch (model.level) {
          case 1:
            model.fetchLevel1Quizzes();
            break;
          case 2:
            model.fetchLevel2Quizzes();
            break;
          case 3:
            model.fetchLevel3Quizzes();
            break;
        }
        final quizzes = model.quizzes;
        final _questionNumber = model.questionNumber;
        return Container(
          decoration: backgroundImage(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                _question(quizzes[_questionNumber].question, _questionNumber + 1),
                Spacer(flex: 2),
                _choiceButton(choice: quizzes[_questionNumber].option1, answer: quizzes[_questionNumber].correct, context: context, model: model),
                _choiceButton(choice: quizzes[_questionNumber].option2, answer: quizzes[_questionNumber].correct, context: context, model: model),
                _choiceButton(choice: quizzes[_questionNumber].option3, answer: quizzes[_questionNumber].correct, context: context, model: model),
                _choiceButton(choice: quizzes[_questionNumber].option4, answer: quizzes[_questionNumber].correct, context: context, model: model),
                Spacer(),
              ],
            ),
          ),
        );
      }),
    );
  }
}
