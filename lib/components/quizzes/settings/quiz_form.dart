import 'package:bz_quiz/components/common/app-bar.dart';
import 'package:bz_quiz/components/common/backgroung_image.dart';
import 'package:bz_quiz/models/quiz_model.dart';
import 'package:bz_quiz/providers/quiz_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class QuizFormPage extends StatelessWidget {
  QuizFormPage({this.quiz});
  final Quiz quiz;
  final questionController = TextEditingController();
  final option1Controller = TextEditingController();
  final option2Controller = TextEditingController();
  final option3Controller = TextEditingController();
  final option4Controller = TextEditingController();
  final correctController = TextEditingController();
  final answerController = TextEditingController();
  final levelController = TextEditingController();
  final randomController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bool isUpdate = quiz != null;
    questionController.text = isUpdate ? quiz.question : '';
    option1Controller.text = isUpdate ? quiz.option1 : '';
    option2Controller.text = isUpdate ? quiz.option2 : '';
    option3Controller.text = isUpdate ? quiz.option3 : '';
    option4Controller.text = isUpdate ? quiz.option4 : '';
    correctController.text = isUpdate ? quiz.correct : '';
    levelController.text = isUpdate ? quiz.level.toString() : '';
    randomController.text = isUpdate ? quiz.random.toString() : '';

    return ChangeNotifierProvider<QuizFormProvider>(
      create: (_) => QuizFormProvider(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            appBar: appBar(isUpdate ? 'クイズ編集' : 'クイズ追加'),
            body: Consumer<QuizFormProvider>(
              builder: (context, model, child) {
                return SingleChildScrollView(
                  child: Container(
                    height: constraints.maxHeight,
                    padding: const EdgeInsets.all(20.0),
                    decoration: backgroundImage(),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: questionController,
                          autofocus: true,
                          decoration: InputDecoration(
                            labelText: '問題',
                            labelStyle: TextStyle(fontSize: 20.0),
                          ),
                          onChanged: (value) {
                            model.question = value;
                          },
                        ),
                        TextField(
                          controller: option1Controller,
                          decoration: InputDecoration(
                            labelText: '選択肢1',
                            labelStyle: TextStyle(fontSize: 20.0),
                          ),
                          onChanged: (value) {
                            model.option1 = value;
                          },
                        ),
                        TextField(
                          controller: option2Controller,
                          decoration: InputDecoration(
                            labelText: '選択肢2',
                            labelStyle: TextStyle(fontSize: 20.0),
                          ),
                          onChanged: (value) {
                            model.option2 = value;
                          },
                        ),
                        TextField(
                          controller: option3Controller,
                          decoration: InputDecoration(
                            labelText: '選択肢3',
                            labelStyle: TextStyle(fontSize: 20.0),
                          ),
                          onChanged: (value) {
                            model.option3 = value;
                          },
                        ),
                        TextField(
                          controller: option4Controller,
                          decoration: InputDecoration(
                            labelText: '選択肢4',
                            labelStyle: TextStyle(fontSize: 20.0),
                          ),
                          onChanged: (value) {
                            model.option4 = value;
                          },
                        ),
                        TextField(
                          controller: correctController,
                          decoration: InputDecoration(
                            labelText: '答え',
                            labelStyle: TextStyle(fontSize: 20.0),
                          ),
                          onChanged: (value) {
                            model.correct = value;
                          },
                        ),
                        TextField(
                          controller: levelController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'レベル',
                            labelStyle: TextStyle(fontSize: 20.0),
                          ),
                          onChanged: (value) {
                            model.level = value;
                          },
                        ),
                        TextField(
                          controller: randomController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'ランダム',
                            labelStyle: TextStyle(fontSize: 20.0),
                          ),
                          onChanged: (value) {
                            model.random = value;
                          },
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10.0),
                          child: RaisedButton(
                            child: Text(isUpdate ? '更新する' : '追加する'),
                            onPressed: () async {
                              isUpdate ? await updateQuiz(model, context) : await addQuiz(model, context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Future addQuiz(QuizFormProvider model, BuildContext context) async {
    try {
      await model.addQuizToFirestore();
      await showDialog<void>(
        context: context,
        // OKボタンをタップしないと、ダイアログ消えない
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('保存しました'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      Navigator.of(context).pop();
    } catch (e) {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(e),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future updateQuiz(QuizFormProvider model, BuildContext context) async {
    try {
      print(model.question);
      print(quiz.question);
      await model.updateQuiz(quiz);
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('更新しました'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      Navigator.of(context).pop();
    } catch (e) {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(e),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
