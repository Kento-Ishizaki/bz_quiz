import 'package:bz_quiz/models/quiz_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QuizProvider extends ChangeNotifier {
  List<Quiz> allQuizzes = [];
  List<Quiz> quizzes = [];
  int _finalScore = 0;
  int _questionNumber = 0;
  int _level;

  int get finalScore => _finalScore;
  int get questionNumber => _questionNumber;
  int get level => _level;

  Future fetchAllQuizzes() async {
    final docs = await Firestore.instance.collection('quizzes').getDocuments();
    final quizzes = docs.documents.map((doc) => Quiz(doc)).toList();
    this.allQuizzes = quizzes;
    notifyListeners();
  }

  Future fetchLevel1Quizzes() async {
    final docs = await Firestore.instance.collection('quizzes').where('level', isEqualTo: 1).getDocuments();
    List quizzes = docs.documents.map((doc) => Quiz(doc)).toList();
    quizzes.shuffle();
    this.quizzes = quizzes.sublist(0, 6);
  }

  Future fetchLevel2Quizzes() async {
    final docs = await Firestore.instance.collection('quizzes').where('level', isEqualTo: 2).getDocuments();
    List quizzes = docs.documents.map((doc) => Quiz(doc)).toList();
    quizzes.shuffle();
    this.quizzes = quizzes.sublist(0, 6);
  }

  Future fetchLevel3Quizzes() async {
    final docs = await Firestore.instance.collection('quizzes').where('level', isEqualTo: 3).getDocuments();
    List quizzes = docs.documents.map((doc) => Quiz(doc)).toList();
    quizzes.shuffle();
    this.quizzes = quizzes.sublist(0, 6);
  }

  Future<void> setLevel({int level}) async {
    _level = level;
    notifyListeners();
  }

  void addFinalScore() {
    _finalScore++;
    notifyListeners();
  }

  void addQuestionNumber() {
    _questionNumber++;
    notifyListeners();
  }

  void resetQuiz() {
    _finalScore = 0;
    _questionNumber = 0;
    notifyListeners();
  }
}
