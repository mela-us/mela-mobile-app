import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/constants/strings.dart';
import 'package:mela/presentation/signup_login_screen/login_or_signup_screen.dart';
import 'package:mela/utils/routes/routes.dart';
import 'package:sembast/sembast.dart';
// import 'package:mela/presentation/home/home.dart';
// import 'package:mela/presentation/home/store/language/language_store.dart';
// import 'package:mela/presentation/login/login.dart';
// import 'package:mela/presentation/login/store/login_store.dart';
// import 'package:mela/utils/locale/app_localization.dart';
// import 'package:mela/utils/routes/routes.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';

import '../constants/route_observer.dart';
import '../di/service_locator.dart';

import 'courses_screen/courses_screen.dart';
import 'courses_screen/store/theme_store/theme_store.dart';
import 'filter_screen/filter_screen.dart';
import 'signup_login_screen/store/user_login_store/user_login_store.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // Create your store as a final variable in a base Widget. This works better
  // with Hot Reload than creating it directly in the `build` function.
  final ThemeStore _themeStore = getIt<ThemeStore>();
  // final LanguageStore _languageStore = getIt<LanguageStore>();
  final UserLoginStore _userStore = getIt<UserLoginStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return MaterialApp(
          navigatorObservers: [routeObserver],
          debugShowCheckedModeBanner: false,
          title: Strings.appName,
          theme: _themeStore.darkMode
              ? AppThemeData.darkThemeData
              : AppThemeData.lightThemeData,
          routes: Routes.routes,
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
          home: _userStore.isLoggedIn ? CoursesScreen() : LoginOrSignupScreen(),
          //home: LoginOrSignupScreen(),
          //  home: FilterScreen(),
        );
      },
    );
  }
}
