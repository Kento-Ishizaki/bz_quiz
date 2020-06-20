import 'package:bz_quiz/components/common/app-bar.dart';
import 'package:bz_quiz/components/common/backgroung_image.dart';
import 'package:bz_quiz/services/quiz_form_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class QuizFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<QuizFormService>(
      create: (_) => QuizFormService(),
      child: LayoutBuilder(builder: (context, constraints) {
        return Scaffold(
          appBar: appBar('クイズ追加'),
          body: Consumer<QuizFormService>(
            builder: (context, model, child) {
              return SingleChildScrollView(
                child: Container(
                  height: constraints.maxHeight,
                  padding: const EdgeInsets.all(20.0),
                  decoration: backgroundImage(),
                  child: Column(
                    children: <Widget>[
                      TextField(
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
                        decoration: InputDecoration(
                          labelText: '選択肢1',
                          labelStyle: TextStyle(fontSize: 20.0),
                        ),
                        onChanged: (value) {
                          model.option1 = value;
                        },
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: '選択肢2',
                          labelStyle: TextStyle(fontSize: 20.0),
                        ),
                        onChanged: (value) {
                          model.option2 = value;
                        },
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: '選択肢3',
                          labelStyle: TextStyle(fontSize: 20.0),
                        ),
                        onChanged: (value) {
                          model.option3 = value;
                        },
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: '選択肢4',
                          labelStyle: TextStyle(fontSize: 20.0),
                        ),
                        onChanged: (value) {
                          model.option4 = value;
                        },
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: '答え',
                          labelStyle: TextStyle(fontSize: 20.0),
                        ),
                        onChanged: (value) {
                          model.correct = value;
                        },
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'レベル',
                          labelStyle: TextStyle(fontSize: 20.0),
                        ),
                        onChanged: (value) {
                          model.level = value;
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: RaisedButton(
                          child: Text('追加する'),
                          onPressed: () async {
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
                                // OKボタンをタップしないと、ダイアログ消えない
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
      }),
    );
  }
}
