import 'package:bz_quiz/components/authenticates/start_button.dart';
import 'package:bz_quiz/components/common/app-bar.dart';
import 'package:bz_quiz/components/common/backgroung_image.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('B\'z Quiz'),
      body: Container(
        decoration: backgroundImage(),
        child: Center(
          child: StartButton(),
        ),
      ),
    );
  }
}
