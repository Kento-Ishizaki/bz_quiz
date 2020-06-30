import 'package:bz_quiz/models/quiz_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QuizFormProvider extends ChangeNotifier {
  String question = '';
  String option1 = '';
  String option2 = '';
  String option3 = '';
  String option4 = '';
  String correct = '';
  // int型だとなぜかフォームから受け取れないので、一旦String型で受ける
  String level = '';
  String random = '';

  Future addQuizToFirestore() async {
    if (question.isEmpty) {
      throw '問題を入力してください。';
    } else if (correct.isEmpty) {
      throw '答えを入力してください。';
    }
    Firestore.instance.collection('quizzes').add(
      <String, dynamic>{
        'question': question,
        'option1': option1,
        'option2': option2,
        'option3': option3,
        'option4': option4,
        'correct': correct,
        // int型へパース
        'level': int.parse(level),
        'random': int.parse(random),
        'createdAt': Timestamp.now(),
      },
    );
  }

  Future updateQuiz(Quiz quiz) async {
    final document = Firestore.instance.collection('quizzes').document(quiz.documentID);
    await document.updateData(
      <String, dynamic>{
        'question': question.isEmpty ? quiz.question : question,
        'option1': option1.isEmpty ? quiz.option1 : option1,
        'option2': option2.isEmpty ? quiz.option2 : option2,
        'option3': option3.isEmpty ? quiz.option3 : option3,
        'option4': option4.isEmpty ? quiz.option4 : option4,
        'correct': correct.isEmpty ? quiz.correct : correct,
        // int型へパース
        'level': level.isEmpty ? quiz.level : int.parse(level),
        'random': random.isEmpty ? quiz.random : int.parse(random),
        'updatedAt': Timestamp.now(),
      },
    );
  }
}
