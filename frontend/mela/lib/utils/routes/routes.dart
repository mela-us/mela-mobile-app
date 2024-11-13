import 'package:flutter/material.dart';
import 'package:mela/presentation/question/question.dart';
import 'package:mela/presentation/result/result.dart';
import 'package:mela/presentation/review/review.dart';

import '../../presentation/home/home.dart';
import '../../presentation/login/login.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/post';
  static const String question = '/question';
  static const String result = '/result';
  static const String review = '/review';

  static final routes = <String, WidgetBuilder>{
    login: (BuildContext context) => LoginScreen(),
    home: (BuildContext context) => HomeScreen(),
    question: (BuildContext context) => QuestionScreen(),
    result: (BuildContext context) => ResultScreen(),
    review: (BuildContext context) => ReviewScreen(),
  };
}
