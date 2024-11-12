import 'package:flutter/material.dart';
import 'package:mela/presentation/divided_lectures_and_exercises_screen/divided_lectures_and_exercises_screen.dart';
import 'package:mela/presentation/home/home.dart';
import 'package:mela/presentation/lectures_in_topic_screen/all_lectures_in_topic_screen.dart';
import 'package:mela/presentation/search_screen/search_screen.dart';

import '../../presentation/courses_screen/courses_screen.dart';
import '../../presentation/signup_login_screen/login_screen.dart';
import '../../presentation/signup_login_screen/signup_screen.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String loginScreen = '/login';
  static const String home = '/post';
  static const String coursesScreen = '/courses_screen';
  static const String signupScreen = '/signup';
  static const String allLecturesInTopicScreen = '/all_lectures_in_topic_screen';
  static const String dividedLecturesAndExercisesScreen = '/divided_lectures_and_exercises_screen';
  static const String searchScreen = '/search_screen';

  static final routes = <String, WidgetBuilder>{
    loginScreen: (BuildContext context) => LoginScreen(),
    signupScreen: (BuildContext context) => SignUpScreen(),
    home: (BuildContext context) => HomeScreen(),
    coursesScreen: (BuildContext context) => CoursesScreen(),
    allLecturesInTopicScreen: (BuildContext context) => AllLecturesInTopicScreen(),
    dividedLecturesAndExercisesScreen: (BuildContext context) => DividedLecturesAndExercisesScreen(),
    searchScreen: (BuildContext context) => SearchScreen(),
  };
}
