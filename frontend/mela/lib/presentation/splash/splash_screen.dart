import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mela/constants/strings.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/main.dart';
import 'package:mela/presentation/signup_login_screen/store/user_login_store/user_login_store.dart';
import 'package:mela/utils/routes/routes.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoading = true;
  final UserLoginStore _userStore = getIt<UserLoginStore>();

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash/splash_screen.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
