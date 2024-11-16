import 'package:flutter/material.dart';

import '../../presentation/home/home.dart';
import '../../presentation/login/login.dart';
import '../../presentation/personal/personal.dart';
import '../../presentation/stats/stats.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/post';
  static const String question = '/question';
  static const String result = '/result';
  static const String review = '/review';
  static const String personal = '/personal';
  static const String stats = '/stats';

  static final routes = <String, WidgetBuilder>{
    login: (BuildContext context) => LoginScreen(),
    home: (BuildContext context) => HomeScreen(),
    personal: (BuildContext context) => PersonalScreen(),
    stats: (BuildContext context) => StatisticsScreen(),
  };
}