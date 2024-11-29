import 'dart:async';

import 'package:mela/data/network/apis/questions/questions_api.dart';
import 'package:mela/data/repository/question/question_repository_impl.dart';
import 'package:mela/data/repository/setting/setting_repository_impl.dart';
import 'package:mela/data/sharedpref/shared_preference_helper.dart';
import 'package:mela/domain/repository/question/question_repository.dart';
import 'package:mela/domain/repository/setting/setting_repository.dart';

import '../../../di/service_locator.dart';
import 'package:mela/data/repository/exercise/exercise_repository_impl.dart';
import 'package:mela/data/repository/lecture/lecture_repository_impl.dart';
import 'package:mela/data/repository/search/search_repository_impl.dart';
import 'package:mela/domain/repository/exercise/exercise_repository.dart';

import 'package:mela/domain/repository/topic/topic_repository.dart';
import 'package:mela/domain/repository/user_login/user_login_repository.dart';
import 'package:mela/domain/repository/user_register/user_signup_repostiory.dart';

import '../../../domain/repository/lecture/lecture_repository.dart';
import '../../../domain/repository/search/search_repository.dart';

import '../../repository/topic/topic_repository_impl.dart';
import '../../repository/user_login/user_login_repository_impl.dart';
import '../../repository/user_signup/user_signup_repository_impl.dart';
import 'package:mela/data/repository/user/user_repository_impl.dart';
import 'package:mela/domain/repository/stat/stat_repository.dart';
import 'package:mela/domain/repository/user/user_repository.dart';

import '../../repository/stat/stat_repository_impl.dart';

class RepositoryModule {
  static Future<void> configureRepositoryModuleInjection() async {
    // repository:--------------------------------------------------------------

    //UserInfor:
    getIt.registerSingleton<UserRepository>(
        UserRepositoryImpl(getIt<SharedPreferenceHelper>()));

    //Setting:------------------------------------------------------------------
    getIt.registerSingleton<SettingRepository>(SettingRepositoryImpl(
      getIt<SharedPreferenceHelper>(),
    ));

    //Authenticate:-------------------------------------------------------------

    getIt.registerSingleton<UserLoginRepository>(UserLoginRepositoryImpl(
      getIt<SharedPreferenceHelper>(),
    ));
    getIt.registerSingleton<UserSignUpRepository>(UserSignupRepositoryImpl());

    //Content Deli:-------------------------------------------------------------

    getIt.registerSingleton<TopicRepository>(TopicRepositoryImpl());
    getIt.registerSingleton<LectureRepository>(LectureRepositoryImpl());
    getIt.registerSingleton<ExerciseRepository>(ExerciseRepositoryImpl());
    getIt.registerSingleton<SearchRepository>(SearchRepositoryImpl());


    getIt.registerSingleton<StatRepository>(
        StatRepositoryImpl() as StatRepository);
    //Practice De
    getIt.registerSingleton<QuestionRepository>(
        QuestionRepositoryImpl(
          getIt<QuestionsApi>(),
        ) as QuestionRepository);
  }
}
