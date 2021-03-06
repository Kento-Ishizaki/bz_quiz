import 'package:bz_quiz/components/quizzes/plays/level.dart';
import 'package:bz_quiz/services/auth_service.dart';
import 'package:flutter/material.dart';

class StartButton extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SizedBox(
          width: 250.0,
          height: 100.0,
          child: RaisedButton(
            child: Text(
              'クイズ開始',
              textScaleFactor: 1.4,
            ),
            onPressed: () async {
              dynamic result = await _auth.signInAnon();
              if (result == null) {
                print('error signing in');
                throw '認証に失敗しました';
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Level()),
                );
                print(result);
              }
            },
          ),
        ),
      ),
    );
  }
}
