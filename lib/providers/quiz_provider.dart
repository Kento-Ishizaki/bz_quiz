import 'package:bz_quiz/models/quiz_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QuizProvider extends ChangeNotifier {
  List<Quiz> quizzes = [];

  Future fetchAllQuizzes() async {
    final docs = await Firestore.instance.collection('quizzes').getDocuments();
    final quizzes = docs.documents.map((doc) => Quiz(doc)).toList();
    this.quizzes = quizzes;
    notifyListeners();
  }

  Future fetchLevel1Quizzes() async {
    final docs = await Firestore.instance.collection('quizzes').where('level', isEqualTo: 1).getDocuments();
    final quizzes = docs.documents.map((doc) => Quiz(doc)).toList();
    this.quizzes = quizzes;
    notifyListeners();
  }

  Future fetchLevel2Quizzes() async {
    final docs = await Firestore.instance.collection('quizzes').where('level', isEqualTo: 2).getDocuments();
    final quizzes = docs.documents.map((doc) => Quiz(doc)).toList();
    this.quizzes = quizzes;
    notifyListeners();
  }

  Future fetchLevel3Quizzes() async {
    final docs = await Firestore.instance.collection('quizzes').where('level', isEqualTo: 3).getDocuments();
    final quizzes = docs.documents.map((doc) => Quiz(doc)).toList();
    this.quizzes = quizzes;
    notifyListeners();
  }
}
