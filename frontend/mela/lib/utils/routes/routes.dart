import 'package:flutter/material.dart';
import 'package:mela/core/widgets/screen_wrapper.dart';
import 'package:mela/presentation/chat/chat_screen.dart';
import 'package:mela/presentation/forgot_password_screen/create_new_password_in_forgot_password_screen.dart';
import 'package:mela/presentation/forgot_password_screen/enter_email_in_forgot_password_screen.dart';
import 'package:mela/presentation/forgot_password_screen/enter_otp_in_forgot_password_screen.dart';
import 'package:mela/presentation/home_screen/home_screen.dart';
import 'package:mela/presentation/question/question.dart';
import 'package:mela/presentation/result/result.dart';
import 'package:mela/presentation/review/review.dart';

import 'package:mela/presentation/divided_lectures_and_exercises_screen/divided_lectures_and_exercises_screen.dart';
import 'package:mela/presentation/search_screen/search_screen.dart';
import 'package:mela/presentation/thread_chat/thread_chat_screen.dart';
import 'package:mela/presentation/topic_lecture_in_level_screen/topic_lecture_in_level_screen.dart';

import '../../presentation/all_screens.dart';
import '../../presentation/filter_screen/filter_screen.dart';
import '../../presentation/signup_login_screen/login_or_signup_screen.dart';
import '../../presentation/signup_login_screen/login_screen.dart';
import '../../presentation/signup_login_screen/signup_screen.dart';

import '../../presentation/personal/personal.dart';
import '../../presentation/stats/stat_filter.dart';
import '../../presentation/stats/stat_search.dart';
import '../../presentation/stats/stats.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String loginScreen = '/login';
  static const String loginOrSignupScreen = '/login_or_signup';
  static const String enterEmailInForgotPasswordScreen =
      '/enter_email_in_forgot_password_screen';
  static const String enterOTPInForgotPasswordScreen =
      '/enter_otp_in_forgot_password_screen';
  static const String createNewPasswordInForgotPasswordScreen =
      '/create_new_password_in_forgot_password_screen';
  static const String coursesScreen = '/courses_screen';
  static const String signupScreen = '/signup';
  // static const String allLecturesInTopicScreen =
  //     '/all_lectures_in_topic_screen';
  static const String topicLectureInLevelScreen =
      '/topic_lecture_in_level_screen';
  static const String dividedLecturesAndExercisesScreen =
      '/divided_lectures_and_exercises_screen';
  static const String searchScreen = '/search_screen';
  static const String filterScreen = '/filter_screen';
  static const String question = '/question';
  static const String result = '/result';
  static const String review = '/review';
  static const String personal = '/personal';
  static const String stats = '/stats';
  static const String searchStats = '/search_stats';
  static const String filterStats = '/filter_stats';
  static const String homeScreen = "/home_screen";
  static const String chat = "/chat";
  static const String allScreens = '/all_screens';
  static const String threadChatScreen = '/thread_chat_screen';

  // static final routes = <String, WidgetBuilder>{
  //   loginScreen: (BuildContext context) => const ScreenWrapper(child:LoginScreen()),
  //   signupScreen: (BuildContext context) => const ScreenWrapper(child:SignUpScreen()),
  //
  //   loginOrSignupScreen: (BuildContext context) =>
  //       ScreenWrapper(child:LoginOrSignupScreen()),
  //
  //   enterEmailInForgotPasswordScreen: (BuildContext context) =>
  //       ScreenWrapper(child: EnterEmailInForgotPasswordScreen()),
  //
  //   enterOTPInForgotPasswordScreen: (BuildContext context) =>
  //       const ScreenWrapper(child: EnterOTPInForgotPasswordScreen()),
  //
  //   createNewPasswordInForgotPasswordScreen: (BuildContext context) =>
  //       ScreenWrapper(child: CreateNewPasswordInForgotPasswordScreen()),
  //   //coursesScreen: (BuildContext context) => const CoursesScreen(),
  //
  //   homeScreen: (BuildContext context) =>
  //       const ScreenWrapper(child: HomeScreen()),
  //   // allLecturesInTopicScreen: (BuildContext context) =>
  //   //     AllLecturesInTopicScreen(),
  //   topicLectureInLevelScreen: (BuildContext context) =>
  //       ScreenWrapper(child: TopicLectureInLevelScreen()),
  //
  //   dividedLecturesAndExercisesScreen: (BuildContext context) =>
  //       ScreenWrapper(child: DividedLecturesAndExercisesScreen()),
  //
  //   searchScreen: (BuildContext context) =>
  //       const ScreenWrapper(child: SearchScreen()),
  //
  //   filterScreen: (BuildContext context) =>
  //       ScreenWrapper(child: FilterScreen()),
  //
  //   question: (BuildContext context) =>
  //       ScreenWrapper(child: QuestionScreen()),
  //
  //   result: (BuildContext context) =>
  //       ScreenWrapper(child: ResultScreen()),
  //
  //   review: (BuildContext context) =>
  //       ScreenWrapper(child: ReviewScreen()),
  //
  //   personal: (BuildContext context) =>
  //       const ScreenWrapper(child: PersonalScreen()),
  //
  //   stats: (BuildContext context) =>
  //       ScreenWrapper(child: StatisticsScreen()),
  //
  //   searchStats: (BuildContext context) =>
  //       const ScreenWrapper(child: StatSearchScreen()),
  //
  //   filterStats: (BuildContext context) =>
  //       ScreenWrapper(child: FilterStatScreen()),
  //
  //   threadChatScreen: (BuildContext context) =>
  //       ScreenWrapper(child: ThreadChatScreen()),
  //
  //   chat: (BuildContext context) =>
  //       const ScreenWrapper(child: ChatScreen()),
  //
  //   allScreens: (BuildContext context) =>
  //       ScreenWrapper(child: AllScreens()),
  // };

  static final routes = <String, WidgetBuilder>{
    loginScreen: (BuildContext context) => const LoginScreen(),
    signupScreen: (BuildContext context) => const SignUpScreen(),

    loginOrSignupScreen: (BuildContext context) => LoginOrSignupScreen(),

    enterEmailInForgotPasswordScreen: (BuildContext context) =>
        EnterEmailInForgotPasswordScreen(),

    enterOTPInForgotPasswordScreen: (BuildContext context) =>
        const EnterOTPInForgotPasswordScreen(),

    createNewPasswordInForgotPasswordScreen: (BuildContext context) =>
        CreateNewPasswordInForgotPasswordScreen(),
    //coursesScreen: (BuildContext context) => const CoursesScreen(),

    homeScreen: (BuildContext context) => const HomeScreen(),
    // allLecturesInTopicScreen: (BuildContext context) =>
    //     AllLecturesInTopicScreen(),
    topicLectureInLevelScreen: (BuildContext context) =>
        TopicLectureInLevelScreen(),

    dividedLecturesAndExercisesScreen: (BuildContext context) =>
        DividedLecturesAndExercisesScreen(),

    searchScreen: (BuildContext context) => const SearchScreen(),

    filterScreen: (BuildContext context) => FilterScreen(),

    question: (BuildContext context) => QuestionScreen(),

    result: (BuildContext context) => ResultScreen(),

    review: (BuildContext context) => ReviewScreen(),

    personal: (BuildContext context) => const PersonalScreen(),

    stats: (BuildContext context) => StatisticsScreen(),

    searchStats: (BuildContext context) => const StatSearchScreen(),

    filterStats: (BuildContext context) => FilterStatScreen(),

    threadChatScreen: (BuildContext context) => ThreadChatScreen(),

    chat: (BuildContext context) => ChatScreen(),

    allScreens: (BuildContext context) => AllScreens(),
  };
}
