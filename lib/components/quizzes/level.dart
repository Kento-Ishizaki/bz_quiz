import 'package:bz_quiz/components/common/app-bar.dart';
import 'package:bz_quiz/components/common/backgroung_image.dart';
import 'package:bz_quiz/components/quizzes/quiz.dart';
import 'package:flutter/material.dart';

class Level extends StatelessWidget {
  List _levels = ['初級', '中級', '上級'];
  List _levelColors = [Colors.pink[300], Colors.pink[500], Colors.red[800]];
  List<Widget> _levelCards = List<Widget>();

  List<Widget> _levelCardsWidget(BuildContext context) {
    for (var i = 0; i < _levels.length; i++) {
      _levelCards.add(
        Card(
          color: _levelColors[i].withOpacity(0.9),
          child: InkWell(
            splashColor: Colors.white.withAlpha(100),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Quiz()),
              );
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
    return Scaffold(
      appBar: appBar('レベル選択'),
      body: Container(
        decoration: backgroundImage(),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _levelCardsWidget(context),
            ),
          ),
        ),
      ),
    );
  }
}
