import 'package:bz_quiz/components/common/app-bar.dart';
import 'package:bz_quiz/components/common/backgroung_image.dart';
import 'package:bz_quiz/components/quizzes/settings/quiz_form.dart';
import 'package:bz_quiz/providers/quiz_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IndexQuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('クイズ一覧'),
      body: Consumer<QuizProvider>(
        builder: (context, model, child) {
          model.fetchAllQuizzes();
          final quizzes = model.allQuizzes;
          final listTiles = quizzes
              .map(
                (quiz) => Card(
                  color: Colors.grey[700],
                  child: InkWell(
                    splashColor: Colors.white.withAlpha(100),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizFormPage(quiz: quiz),
                          fullscreenDialog: true,
                        ),
                      );
                      model..fetchAllQuizzes();
                    },
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      height: 50.0,
                      child: Center(
                        child: Text(
                          quiz.question,
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList();
          return Container(
            decoration: backgroundImage(),
            child: Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: ListView(
                children: listTiles,
              ),
            ),
          );
        },
      ),
      floatingActionButton: Consumer<QuizProvider>(
        builder: (context, model, child) {
          return FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizFormPage(),
                  fullscreenDialog: true,
                ),
              );
              model.fetchAllQuizzes();
            },
          );
        },
      ),
    );
  }
}
