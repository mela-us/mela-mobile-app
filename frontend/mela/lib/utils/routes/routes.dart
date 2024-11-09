import 'package:flutter/material.dart';
import 'package:mela/presentation/home/home.dart';

import '../../presentation/courses_screen/courses_screen.dart';
import '../../presentation/signup_login_screen/login_screen.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/post';
  static const String coursesScreen = '/courses_screen';

  static final routes = <String, WidgetBuilder>{
    login: (BuildContext context) => LoginScreen(onChangeToSignUp: (){}),
    home: (BuildContext context) => HomeScreen(),
    coursesScreen: (BuildContext context) => CoursesScreen(),
  };
}
