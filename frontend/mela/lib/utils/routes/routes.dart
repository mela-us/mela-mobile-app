import 'package:flutter/material.dart';
import 'package:mela/presentation/home/home.dart';

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

  static final routes = <String, WidgetBuilder>{
    loginScreen: (BuildContext context) => LoginScreen(),
    signupScreen: (BuildContext context) => SignUpScreen(),
    home: (BuildContext context) => HomeScreen(),
    coursesScreen: (BuildContext context) => CoursesScreen(),
  };
}
