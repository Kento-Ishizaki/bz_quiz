import 'package:bz_quiz/models/quiz_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QuizService extends ChangeNotifier {
  List<QuizModel> quizzes = [];
//  String option1;
//  String option2;
//  String option3;
//  String option4;
//  int level;
//  String correct;
//  var createdAt;
//  var updatedAt;

  Future fetchQuizzes() async {
    final docs = await Firestore.instance.collection('quizzes').getDocuments();
    final quizzes = docs.documents.map((doc) => QuizModel(doc['question'])).toList();
    this.quizzes = quizzes;
    notifyListeners();
  }
}
