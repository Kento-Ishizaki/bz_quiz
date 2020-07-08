import 'dart:math' as math;

import 'package:bz_quiz/components/common/app-bar.dart';
import 'package:bz_quiz/components/common/backgroung_image.dart';
import 'package:bz_quiz/components/quizzes/plays/play_quiz.dart';
import 'package:bz_quiz/providers/quiz_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class Level extends StatelessWidget {
  final List _levels = ['初級', '中級', '上級'];
  final List _levelColors = [Colors.pink[300], Colors.pink[500], Colors.red[800]];
  final List<Widget> _levelCards = List<Widget>();
  final _rand = math.Random();
  int index(int min, int max) => min + _rand.nextInt(max - min);

  List<Widget> _levelCardsWidget({BuildContext context, dynamic model}) {
    for (var i = 0; i < _levels.length; i++) {
      _levelCards.add(
        Card(
          color: _levelColors[i].withOpacity(0.9),
          child: InkWell(
            splashColor: Colors.white.withAlpha(100),
            onTap: () async {
              model.changeState();
              await Future.delayed(Duration(milliseconds: 500));
              await Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => PlayQuiz(level: i + 1),
                ),
                (Route<dynamic> route) => false,
              );
              model.changeState();
            },
            child: Container(
              width: 300,
              height: 100,
              child: Center(
                child: Text(
                  _levels[i],
                  textScaleFactor: 1.5,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return _levelCards;
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<QuizProvider>(context, listen: false).fetchLevel1Quizzes();
    Provider.of<QuizProvider>(context, listen: false).fetchLevel2Quizzes();
    Provider.of<QuizProvider>(context, listen: false).fetchLevel3Quizzes();
    Provider.of<QuizProvider>(context, listen: false).resetState();
    Provider.of<QuizProvider>(context, listen: false).resetQuiz();
    return Scaffold(
      appBar: appBar('レベル選択'),
      body: Consumer<QuizProvider>(
        builder: (context, model, snapshot) {
          return model.isWaiting == true
              ? SpinKitWave(
                  color: Colors.redAccent,
                )
              : Container(
                  decoration: backgroundImage(),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _levelCardsWidget(context: context, model: model),
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
