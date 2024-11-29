import 'package:flutter/material.dart';
import 'package:mela/presentation/question/question.dart';
import 'package:mela/presentation/result/result.dart';
import 'package:mela/presentation/review/review.dart';

import 'package:mela/presentation/divided_lectures_and_exercises_screen/divided_lectures_and_exercises_screen.dart';
import 'package:mela/presentation/lectures_in_topic_screen/all_lectures_in_topic_screen.dart';
import 'package:mela/presentation/search_screen/search_screen.dart';

import '../../presentation/all_screens.dart';
import '../../presentation/courses_screen/courses_screen.dart';
import '../../presentation/filter_screen/filter_screen.dart';
import '../../presentation/signup_login_screen/login_or_signup_screen.dart';
import '../../presentation/signup_login_screen/login_screen.dart';
import '../../presentation/signup_login_screen/signup_screen.dart';

import '../../presentation/personal/personal.dart';
import '../../presentation/stats/stats.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String loginScreen = '/login';
  static const String loginOrSignupScreen = '/login_or_signup';
  static const String coursesScreen = '/courses_screen';
  static const String signupScreen = '/signup';
  static const String allLecturesInTopicScreen =
      '/all_lectures_in_topic_screen';
  static const String dividedLecturesAndExercisesScreen =
      '/divided_lectures_and_exercises_screen';
  static const String searchScreen = '/search_screen';
  static const String filterScreen = '/filter_screen';
  static const String question = '/question';
  static const String result = '/result';
  static const String review = '/review';
  static const String personal = '/personal';
  static const String stats = '/stats';
  static const String allScreens = '/all_screens';

  static final routes = <String, WidgetBuilder>{
    loginScreen: (BuildContext context) => const LoginScreen(),
    signupScreen: (BuildContext context) => const SignUpScreen(),
    loginOrSignupScreen: (BuildContext context) => LoginOrSignupScreen(),
    coursesScreen: (BuildContext context) => const CoursesScreen(),
    allLecturesInTopicScreen: (BuildContext context) =>
        AllLecturesInTopicScreen(),
    dividedLecturesAndExercisesScreen: (BuildContext context) =>
        DividedLecturesAndExercisesScreen(),
    searchScreen: (BuildContext context) => const SearchScreen(),
    filterScreen: (BuildContext context) => FilterScreen(),
    question: (BuildContext context) => QuestionScreen(),
    result: (BuildContext context) => ResultScreen(),
    review: (BuildContext context) => ReviewScreen(),
    personal: (BuildContext context) => const PersonalScreen(),
    stats: (BuildContext context) => StatisticsScreen(),
    allScreens: (BuildContext context) => AllScreens(),
  };
}
