import 'package:bz_quiz/components/common/app-bar.dart';
import 'package:bz_quiz/components/common/backgroung_image.dart';
import 'package:bz_quiz/components/home/home.dart';
import 'package:bz_quiz/components/quizzes/plays/level.dart';
import 'package:bz_quiz/providers/quiz_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:soundpool/soundpool.dart';

class Result extends StatelessWidget {
  final int score;
  Result({Key key, @required this.score}) : super(key: key);
  final Soundpool _soundpool = Soundpool(streamType: StreamType.notification);

  @override
  Widget build(BuildContext context) {
    _checkPerfect(score);
    return Scaffold(
      appBar: appBar('結果'),
      body: Container(
        decoration: backgroundImage(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Consumer<QuizProvider>(builder: (context, model, child) {
            model.resetQuiz();
            return Center(
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
                    width: 210.0,
                    margin: EdgeInsets.only(top: 50.0),
                    child: RaisedButton(
                      child: const Text(
                        'レベル選択画面に戻る',
                        textScaleFactor: 1.2,
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Level(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                    ),
                  ),
                  Container(
                    height: 70.0,
                    width: 210.0,
                    margin: EdgeInsets.only(top: 50.0),
                    child: RaisedButton(
                      child: const Text(
                        'TOPに戻る',
                        textScaleFactor: 1.2,
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Future<void> _checkPerfect(int score) async {
    if (score == 5) {
      await _playPerfectSound();
    }
  }

  Future<void> _playPerfectSound() async {
    int soundId = await rootBundle.load("assets/sounds/perfect.mp3").then((ByteData soundData) {
      return _soundpool.load(soundData);
    });
    await _soundpool.play(soundId);
  }
}
