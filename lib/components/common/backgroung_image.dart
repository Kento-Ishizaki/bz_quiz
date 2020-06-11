import 'package:flutter/material.dart';

backgroundImage() {
  return BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/background.jpg'),
      fit: BoxFit.cover,
    ),
  );
}
