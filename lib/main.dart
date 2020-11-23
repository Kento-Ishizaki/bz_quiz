import 'package:bz_quiz/components/splashes/splash.dart';
import 'package:bz_quiz/providers/quiz_form_provider.dart';
import 'package:bz_quiz/providers/quiz_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => QuizProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => QuizFormProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'B\'z Quiz',
        theme: ThemeData(
          brightness: Brightness.dark,
          accentColor: Colors.redAccent,
          primaryColorDark: Colors.indigo,
          buttonColor: Colors.redAccent,
        ),
        home: Splash(),
      ),
    );
  }
}
