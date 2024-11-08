// import 'package:flutter/material.dart';
// import 'package:mela/screens/signup_login_screen/login_or_signup_screen.dart';


// void main() {
//   runApp(const MainApp());
// }

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return MaterialApp(
//       title: 'Todo App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: LoginOrSignupScreen(),// Test screen put here.
//     );
//     throw UnimplementedError();
//   }
// }


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await setPreferredOrientations();
  await ServiceLocator.configureDependencies();
  runApp(MyApp());
}

// Future<void> setPreferredOrientations() {
//   return SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//     DeviceOrientation.landscapeRight,
//     DeviceOrientation.landscapeLeft,
//   ]);
// }