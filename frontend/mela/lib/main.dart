import 'package:flutter/material.dart';
import 'package:mela/screens/question_screen/QuestionScreen.dart';

import 'constants/global.dart';

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
      home: QuestionScreen(questions: Global.questions), // Test screen put here.
    );
    throw UnimplementedError();
  }

}
