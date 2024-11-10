// import 'package:flutter/material.dart';

// import 'login_screen.dart';
// import 'signup_screen.dart';

// class LoginOrSignupScreen extends StatefulWidget {
//   const LoginOrSignupScreen({super.key});

//   @override
//   State<LoginOrSignupScreen> createState() => _LoginOrSignupScreenState();
// }

// class _LoginOrSignupScreenState extends State<LoginOrSignupScreen> {
//   bool _isLoginScreen = true;
//   void changeBetweenLoginAndSignupScreen() {
//     setState(() {
//       _isLoginScreen = !_isLoginScreen;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _isLoginScreen
//         ? LoginScreen(
//             onChangeToSignUp: changeBetweenLoginAndSignupScreen,
//           )
//         : SignUpScreen(
//             onChangeToLogin: changeBetweenLoginAndSignupScreen,
//           );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/signup_login_screen/store/login_or_signup_store/login_or_signup_store.dart';

import 'login_screen.dart';
import 'signup_screen.dart';

class LoginOrSignupScreen extends StatelessWidget {
  LoginOrSignupScreen({super.key});

  final LoginOrSignupStore _loginOrSignupStore = getIt<LoginOrSignupStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      print("FlutterDemo: ${_loginOrSignupStore.isLoginScreen}");
      return _loginOrSignupStore.isLoginScreen
          ? const LoginScreen()
          : const SignUpScreen();
    });
  }
}
