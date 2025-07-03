import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'constants/preferences_const.dart';

class SharedPreferenceHelper {
  // shared pref instance
  final SharedPreferences _sharedPreference;

  // constructor
  SharedPreferenceHelper(this._sharedPreference);

  // General Methods: ----------------------------------------------------------
  Future<String?> get authToken async {
    return _sharedPreference.getString(PreferencesConst.auth_token);
  }

  Future<bool> saveAuthToken(String authToken) async {
    return _sharedPreference.setString(PreferencesConst.auth_token, authToken);
  }

  Future<bool> removeAuthToken() async {
    return _sharedPreference.remove(PreferencesConst.auth_token);
  }

  // Login:---------------------------------------------------------------------
  Future<bool> get isLoggedIn async {
    return _sharedPreference.getBool(PreferencesConst.is_logged_in) ?? false;
  }

  //Chat:
  Future<bool> get isFirstTimeGoToChat async {
    return _sharedPreference
            .getBool(PreferencesConst.is_first_time_go_to_chat) ??
        true;
  }

  Future<bool> saveIsFirstTimeGoToChat(bool value) async {
    return _sharedPreference.setBool(
        PreferencesConst.is_first_time_go_to_chat, value);
  }

  Future<bool> get isFirstTimeIntitialMessage async {
    return _sharedPreference
            .getBool(PreferencesConst.is_first_time_intitial_message) ??
        true;
  }

  Future<bool> saveIsFirstTimeIntitialMessage(bool value) async {
    return _sharedPreference.setBool(
        PreferencesConst.is_first_time_intitial_message, value);
  }

  Future<bool> get isFirstTimeReviewMessage async {
    return _sharedPreference
            .getBool(PreferencesConst.is_first_time_review_message) ??
        true;
  }

  Future<bool> saveIsFirstTimeReviewMessage(bool value) async {
    return _sharedPreference.setBool(
        PreferencesConst.is_first_time_review_message, value);
  }

  //Guidance learning for first time go to app.
    Future<bool> get isFirstTimeSeeStreak async {
    return _sharedPreference
            .getBool(PreferencesConst.is_first_time_see_streak) ??
        true;
  }

  Future<bool> saveIsFirstTimeSeeStreak(bool value) async {
    return _sharedPreference.setBool(
        PreferencesConst.is_first_time_see_streak, value);
  }
  Future<bool> get isFirstTimeOpenLevel async {
    return _sharedPreference
            .getBool(PreferencesConst.is_first_time_open_level) ??
        true;
  }

  Future<bool> saveIsFirstTimeOpenLevel(bool value) async {
    return _sharedPreference.setBool(
        PreferencesConst.is_first_time_open_level, value);
  }

  Future<bool> get isFirstTimeOpenLessonInTopic async {
    return _sharedPreference
            .getBool(PreferencesConst.is_first_time_open_lesson_in_topic) ??
        true;
  }

  Future<bool> saveIsFirstTimeOpenLessonInTopic(bool value) async {
    return _sharedPreference.setBool(
        PreferencesConst.is_first_time_open_lesson_in_topic, value);
  }

  //First time how to learnn pdf
  Future<bool> get isFirstTimeGoToPdf async {
    return _sharedPreference
            .getBool(PreferencesConst.is_first_time_go_to_pdf) ??
        true;
  }

  Future<bool> saveIsFirstTimeGoToPdf(bool value) async {
    return _sharedPreference.setBool(
        PreferencesConst.is_first_time_go_to_pdf, value);
  }

  // Save login status:--------------------------------------------------------

  Future<bool> saveIsLoggedIn(bool value) async {
    return _sharedPreference.setBool(PreferencesConst.is_logged_in, value);
  }

  // First time run app:--------------------------------------------------------
  Future<bool> get isFirstTimeRunApp async {
    return _sharedPreference.getBool(PreferencesConst.is_first_time_run_app) ??
        true;
  }

  Future<bool> saveIsFirstTimeRunApp(bool value) async {
    return _sharedPreference.setBool(
        PreferencesConst.is_first_time_run_app, value);
  }

  // Theme:------------------------------------------------------
  bool get isDarkMode {
    return _sharedPreference.getBool(PreferencesConst.is_dark_mode) ?? false;
  }

  Future<void> changeBrightnessToDark(bool value) {
    return _sharedPreference.setBool(PreferencesConst.is_dark_mode, value);
  }

  // Language:---------------------------------------------------
  String? get currentLanguage {
    return _sharedPreference.getString(PreferencesConst.current_language);
  }

  Future<void> changeLanguage(String language) {
    return _sharedPreference.setString(
        PreferencesConst.current_language, language);
  }
}
