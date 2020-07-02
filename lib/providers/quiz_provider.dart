import 'package:bz_quiz/models/quiz_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QuizProvider extends ChangeNotifier {
  List<Quiz> allQuizzes = [];
  List<Quiz> _level1Quizzes = [];
  List<Quiz> _level2Quizzes = [];
  List<Quiz> _level3Quizzes = [];
  int _finalScore = 0;
  int _questionNumber = 0;
  int _level;

  int get finalScore => _finalScore;
  int get questionNumber => _questionNumber;
  int get level => _level;
  List get level1Quizzes => _level1Quizzes;
  List get level2Quizzes => _level2Quizzes;
  List get level3Quizzes => _level3Quizzes;

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
    this._level1Quizzes = quizzes.sublist(0, 6);
  }

  Future fetchLevel2Quizzes() async {
    final docs = await Firestore.instance.collection('quizzes').where('level', isEqualTo: 2).getDocuments();
    List quizzes = docs.documents.map((doc) => Quiz(doc)).toList();
    quizzes.shuffle();
    this._level2Quizzes = quizzes.sublist(0, 6);
  }

  Future fetchLevel3Quizzes() async {
    final docs = await Firestore.instance.collection('quizzes').where('level', isEqualTo: 3).getDocuments();
    List quizzes = docs.documents.map((doc) => Quiz(doc)).toList();
    quizzes.shuffle();
    this._level3Quizzes = quizzes.sublist(0, 6);
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
