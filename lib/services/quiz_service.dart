import 'package:bz_quiz/models/quiz_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QuizService extends ChangeNotifier {
  List<Quiz> quizzes = [];

  Future fetchQuizzes() async {
    final docs = await Firestore.instance.collection('quizzes').getDocuments();
    final quizzes = docs.documents.map((doc) => Quiz(doc)).toList();
    this.quizzes = quizzes;
    notifyListeners();
  }
}
