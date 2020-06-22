import 'package:bz_quiz/components/common/app-bar.dart';
import 'package:bz_quiz/components/common/backgroung_image.dart';
import 'package:bz_quiz/components/quizzes/settings/quiz_form.dart';
import 'package:bz_quiz/services/quiz_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IndexQuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<QuizService>(
      create: (_) => QuizService()..fetchQuizzes(),
      child: Scaffold(
        appBar: appBar('クイズ'),
        body: Consumer<QuizService>(
          builder: (context, model, child) {
            final quizzes = model.quizzes;
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
                        model.fetchQuizzes();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
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
        floatingActionButton: Consumer<QuizService>(
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
                model.fetchQuizzes();
              },
            );
          },
        ),
      ),
    );
  }
}
