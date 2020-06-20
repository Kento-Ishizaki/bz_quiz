import 'package:cloud_firestore/cloud_firestore.dart';

class Quiz {
  Quiz(DocumentSnapshot doc) {
    documentID = doc.documentID;
    question = doc['question'];
    option1 = doc['option1'];
    option2 = doc['option2'];
    option3 = doc['option3'];
    option4 = doc['option4'];
    correct = doc['correct'];
    level = doc['level'];
    random = doc['random'];
  }

  String documentID;
  String question;
  String option1;
  String option2;
  String option3;
  String option4;
  String correct;
  int level;
  int random;
}
