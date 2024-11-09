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
