
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/presentation/stats/stats.dart';

import '../constants/app_theme.dart';
import '../constants/strings.dart';
import '../di/service_locator.dart';
import '../utils/locale/app_localization.dart';
import '../utils/routes/routes.dart';
import 'home/store/language/language_store.dart';
import 'home/store/theme/theme_store.dart';
import 'login/store/login_store.dart';
import 'personal/personal.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // Create your store as a final variable in a base Widget. This works better
  // with Hot Reload than creating it directly in the `build` function.
  final ThemeStore _themeStore = getIt<ThemeStore>();
  final LanguageStore _languageStore = getIt<LanguageStore>();
  final UserStore _userStore = getIt<UserStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: Strings.appName,
          theme: _themeStore.darkMode
              ? AppThemeData.darkThemeData
              : AppThemeData.lightThemeData,
          routes: Routes.routes,
          locale: Locale(_languageStore.locale),
          supportedLocales: _languageStore.supportedLanguages
              .map((language) => Locale(language.locale, language.code))
              .toList(),
          localizationsDelegates: [
            // A class which loads the translations from JSON files
            AppLocalizations.delegate,
            // Built-in localization of basic text for Material widgets
            ///GlobalMaterialLocalizations.delegate,
            // Built-in localization for text direction LTR/RTL
            ///GlobalWidgetsLocalizations.delegate,
            // Built-in localization of basic text for Cupertino widgets
            ///GlobalCupertinoLocalizations.delegate,
          ],
          home: StatisticsScreen(),
        );
      },
    );
  }
}