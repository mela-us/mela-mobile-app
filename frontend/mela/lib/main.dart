import 'package:flutter/material.dart';
import 'package:mela/screens/courses_screen/courses_screen.dart';
import 'package:mela/screens/courses_screen/widgets/cover_image_widget.dart';
import 'package:mela/screens/lectures_in_topic_screen/all_lectures_in_topic_screen.dart';
import 'package:mela/screens/question_screen/QuestionScreen.dart';
import 'package:mela/screens/signup_login_screen/login_or_signup_screen.dart';

import 'constants/global.dart';
import 'models/topic.dart';
import 'screens/signup_login_screen/login_screen.dart';
import 'screens/signup_login_screen/signup_screen.dart';

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
      home: LoginOrSignupScreen(), // Test screen put here.
    );
    throw UnimplementedError();
  }
}
