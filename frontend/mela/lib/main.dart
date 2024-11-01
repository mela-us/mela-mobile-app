import 'package:flutter/material.dart';
import 'package:mela/screens/divided_lectures_and_exercises_screen/divided_lectures_and_exercises_screen.dart';
import 'package:mela/themes/default/text_styles.dart';
import 'package:mela/screens/signup_login_screen/login_or_signup_screen.dart';

import 'models/lecture.dart';
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginOrSignupScreen(),// Test screen put here.
    );
    throw UnimplementedError();
  }
}
