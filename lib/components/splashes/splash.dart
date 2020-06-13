import 'dart:async';

import 'package:bz_quiz/components/common/backgroung_image.dart';
import 'package:bz_quiz/components/home/home.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: backgroundImage(),
        child: Center(
          child: Text(
            'B\'z Quiz',
            textScaleFactor: 3.0,
          ),
        ),
      ),
    );
  }
}
