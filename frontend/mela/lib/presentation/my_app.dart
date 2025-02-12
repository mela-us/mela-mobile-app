// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/constants/strings.dart';
import 'package:mela/domain/entity/post/post_list.dart';
import 'package:mela/presentation/all_screens.dart';
import 'package:mela/presentation/personal/edit_screens/edit_birthdate_screen.dart';
import 'package:mela/presentation/personal/edit_screens/edit_name_screen.dart';
import 'package:mela/presentation/personal/personal.dart';
import 'package:mela/presentation/personal/personal_info.dart';
import 'package:mela/presentation/signup_login_screen/login_or_signup_screen.dart';
import 'package:mela/presentation/stats/stats.dart';
import 'package:mela/utils/routes/routes.dart';
import '../constants/route_observer.dart';
import '../di/service_locator.dart';

import 'signup_login_screen/store/user_login_store/user_login_store.dart';


import '../utils/locale/app_localization.dart';


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // Create your store as a final variable in a base Widget. This works better
  // with Hot Reload than creating it directly in the `build` function.

  // final ThemeStore _themeStore = getIt<ThemeStore>();
  final UserLoginStore _userStore = getIt<UserLoginStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return MaterialApp(
          navigatorObservers: [routeObserver],
          debugShowCheckedModeBanner: false,
          title: Strings.appName,
          theme: AppThemeData.lightThemeData,
          // theme: _themeStore.darkMode
          //     ? AppThemeData.darkThemeData
          //     : AppThemeData.lightThemeData,
          routes: Routes.routes,
          localizationsDelegates: const [
            // A class which loads the translations from JSON files
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            // Built-in localization of basic text for Material widgets
            ///GlobalMaterialLocalizations.delegate,
            // Built-in localization for text direction LTR/RTL
            ///GlobalWidgetsLocalizations.delegate,
            // Built-in localization of basic text for Cupertino widgets
            ///GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('vi', ''), // Vietnamese
          ],
          // home: _userStore.isLoggedIn ? HomeScreen() : LoginScreen(),
          // locale: Locale(_languageStore.locale),
          // supportedLocales: _languageStore.supportedLanguages
          //     .map((language) => Locale(language.locale, language.code))
          //     .toList(),
          // localizationsDelegates: [
          //   // A class which loads the translations from JSON files
          //   AppLocalizations.delegate,
          //   // Built-in localization of basic text for Material widgets
          //   GlobalMaterialLocalizations.delegate,
          //   // Built-in localization for text direction LTR/RTL
          //   GlobalWidgetsLocalizations.delegate,
          //   // Built-in localization of basic text for Cupertino widgets
          //   GlobalCupertinoLocalizations.delegate,
          // ],
          //home: _userStore.isLoggedIn ? AllScreens() : LoginOrSignupScreen(),
          home: const PersonalInfo(
              name: "Phan Nhan",
              dob: "11-08-2003",
              email: "phantrinhanbt@gmail.com",
              imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjgATTypseTuJakR9oTeQKXtxq0kh6Ez7ueg&s",
          ),
        );
      },
    );
  }
}
