// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/constants/strings.dart';
import 'package:mela/data/securestorage/secure_storage_helper.dart';
import 'package:mela/data/sharedpref/shared_preference_helper.dart';
import 'package:mela/domain/entity/post/post_list.dart';
import 'package:mela/presentation/all_screens.dart';
import 'package:mela/presentation/personal/edit_screens/edit_birthdate_screen.dart';
import 'package:mela/presentation/personal/edit_screens/edit_name_screen.dart';
import 'package:mela/presentation/personal/personal.dart';
import 'package:mela/presentation/personal/personal_info.dart';
import 'package:mela/presentation/signup_login_screen/login_or_signup_screen.dart';
import 'package:mela/presentation/splash/splash_screen.dart';
import 'package:mela/presentation/stats/stats.dart';
import 'package:mela/utils/routes/routes.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/route_observer.dart';
import '../di/service_locator.dart';

import 'signup_login_screen/store/user_login_store/user_login_store.dart';


import '../utils/locale/app_localization.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final UserLoginStore _userStore = getIt<UserLoginStore>();
  final SharedPreferenceHelper prefs = getIt<SharedPreferenceHelper>();
  final SecureStorageHelper secureStorageHelper = getIt<SecureStorageHelper>();
  bool isVersionCorrect = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<bool> fetchVersion() async {
    final url = Uri.parse(Strings.appVersionUrl);

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        int latestCount = int.parse(data["count"]);

        PackageInfo packageInfo  = await PackageInfo.fromPlatform();
        String buildNumber = packageInfo.buildNumber;
        int buildNumberInt = int.parse(buildNumber);
        print('Latest count: $latestCount and buildNumber: $buildNumberInt' );
        if (buildNumberInt < latestCount) {
          return true;
        }

      }
    } catch (e) {
      print('Error in fetching version: $e');
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return MaterialApp(
          navigatorObservers: [routeObserver],
          debugShowCheckedModeBanner: false,
          title: Strings.appName,
          theme: AppThemeData.lightThemeData,
          routes: Routes.routes,
          localizationsDelegates: const [
            // A class which loads the translations from JSON files
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          home: FutureBuilder(
              future: fetchVersion(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SplashScreen();
                }
                else if (snapshot.data == true) {
                  WidgetsBinding.instance.addPostFrameCallback((_){
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Yêu cầu cập nhật'),
                            content: const Text(
                                'Đã có phiên bản mới, vui lòng cập nhật thông qua cửa hàng ứng dụng.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () async {
                                  String url = "";
                                  if (Platform.isAndroid) {
                                    url = Strings.googlePlayUrl;
                                  }
                                  if (Platform.isIOS) {
                                    url = Strings.appStoreUrl;
                                  }
                                  //Default as android for edge testing
                                  else {
                                    url = Strings.googlePlayUrl;
                                  }
                                  if (await canLaunchUrl(Uri.parse(url))) {
                                    await launchUrl(
                                        Uri.parse(url),
                                        mode: LaunchMode.externalApplication
                                    );
                                  }
                                  //Reset sharedpref.
                                  await prefs.saveIsLoggedIn(false);
                                  await secureStorageHelper.deleteAll();

                                  SystemNavigator.pop();
                                  exit(0);
                                },
                                child: const Text('Cập nhật'),
                              ),
                            ],
                          );
                        });
                  });
                  return const SplashScreen();
                }
                else if (snapshot.data == false) {
                  return _userStore.isLoggedIn
                      ? AllScreens()
                      : LoginOrSignupScreen();
                }
                return const Scaffold(
                  body: Center(
                    child: Text('Error in fetching version'),
                  ),
                );
              }
              ),

        );
      },
    );
  }


}


//
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   // Create your store as a final variable in a base Widget. This works better
//   // with Hot Reload than creating it directly in the `build` function.
//
//   // final ThemeStore _themeStore = getIt<ThemeStore>();
//   final UserLoginStore _userStore = getIt<UserLoginStore>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Observer(
//       builder: (context) {
//         return MaterialApp(
//           navigatorObservers: [routeObserver],
//           debugShowCheckedModeBanner: false,
//           title: Strings.appName,
//           theme: AppThemeData.lightThemeData,
//           routes: Routes.routes,
//           localizationsDelegates: const [
//             // A class which loads the translations from JSON files
//             AppLocalizations.delegate,
//             GlobalMaterialLocalizations.delegate,
//             GlobalWidgetsLocalizations.delegate,
//             GlobalCupertinoLocalizations.delegate,
//           ],
//
//           home: _userStore.isLoggedIn ? AllScreens() : LoginOrSignupScreen(),
//
//         );
//       },
//     );
//   }
// }
