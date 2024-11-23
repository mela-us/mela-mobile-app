import 'package:flutter/material.dart';
import 'package:mela/presentation/question/question.dart';
import 'package:mela/presentation/result/result.dart';
import 'package:mela/presentation/review/review.dart';

import 'package:mela/presentation/divided_lectures_and_exercises_screen/divided_lectures_and_exercises_screen.dart';
import 'package:mela/presentation/lectures_in_topic_screen/all_lectures_in_topic_screen.dart';
import 'package:mela/presentation/search_screen/search_screen.dart';

import '../../presentation/courses_screen/courses_screen.dart';
import '../../presentation/filter_screen/filter_screen.dart';
import '../../presentation/signup_login_screen/login_screen.dart';
import '../../presentation/signup_login_screen/signup_screen.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String loginScreen = '/login';
  static const String coursesScreen = '/courses_screen';
  static const String signupScreen = '/signup';
  static const String allLecturesInTopicScreen = '/all_lectures_in_topic_screen';
  static const String dividedLecturesAndExercisesScreen =
      '/divided_lectures_and_exercises_screen';
  static const String searchScreen = '/search_screen';
  static const String filterScreen = '/filter_screen';
  static const String question = '/question';
  static const String result = '/result';
  static const String review = '/review';


  static final routes = <String, WidgetBuilder>{
    loginScreen: (BuildContext context) => LoginScreen(),
    signupScreen: (BuildContext context) => SignUpScreen(),
    coursesScreen: (BuildContext context) => CoursesScreen(),
    allLecturesInTopicScreen: (BuildContext context) =>
        AllLecturesInTopicScreen(),
    dividedLecturesAndExercisesScreen: (BuildContext context) =>
        DividedLecturesAndExercisesScreen(),
    searchScreen: (BuildContext context) => SearchScreen(),
    filterScreen: (BuildContext context) => FilterScreen(),
    question: (BuildContext context) => QuestionScreen(),
    result: (BuildContext context) => ResultScreen(),
    review: (BuildContext context) => ReviewScreen(),
  };
}
