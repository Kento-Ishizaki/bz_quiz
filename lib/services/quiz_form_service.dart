import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QuizFormService extends ChangeNotifier {
  String question;
  String option1;
  String option2;
  String option3;
  String option4;
  String correct;
  // int型だとなぜかフォームから受け取れないので、一旦String型で受ける
  String level;

  Future addQuizToFirestore() async {
    print(correct);
    print(level);
    if (question == null) {
      throw '問題を入力してください。';
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
        'createdAt': Timestamp.now(),
      },
    );
  }
}
