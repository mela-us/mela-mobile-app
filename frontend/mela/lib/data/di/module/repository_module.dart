import 'dart:async';

import 'package:mela/data/local/datasources/history_search/history_search_datasource.dart';
import 'package:mela/data/network/apis/chat/chat_api.dart';
import 'package:mela/data/network/apis/level/level_api.dart';
import 'package:mela/data/network/apis/questions/questions_api.dart';
import 'package:mela/data/network/apis/exercises/exercise_api.dart';
import 'package:mela/data/network/apis/forgot_password/forgot_password_api.dart';
import 'package:mela/data/network/apis/lectures/lecture_api.dart';
import 'package:mela/data/network/apis/login_signup/login_api.dart';
import 'package:mela/data/network/apis/login_signup/refresh_access_token_api.dart';
import 'package:mela/data/network/apis/login_signup/signup_api.dart';
import 'package:mela/data/network/apis/searchs/search_api.dart';
import 'package:mela/data/network/apis/topic_lecture/topic_lecture_api.dart';
import 'package:mela/data/network/apis/topics/topic_api.dart';
import 'package:mela/data/network/apis/user/delete_account_api.dart';
import 'package:mela/data/network/apis/user/logout_api.dart';
import 'package:mela/data/network/apis/user/user_info_api.dart';
import 'package:mela/data/repository/chat/chat_repository_impl.dart';
import 'package:mela/data/repository/level/level_repository_impl.dart';
import 'package:mela/data/repository/question/question_repository_impl.dart';
import 'package:mela/data/repository/setting/setting_repository_impl.dart';
import 'package:mela/data/repository/stat/stat_search_impl.dart';
import 'package:mela/data/repository/topic_lecture/topic_lecture_repository_impl.dart';
import 'package:mela/data/securestorage/secure_storage_helper.dart';
import 'package:mela/data/sharedpref/shared_preference_helper.dart';
import 'package:mela/domain/repository/chat/chat_repository.dart';
import 'package:mela/domain/repository/forgot_password/forgot_password_repository.dart';
import 'package:mela/domain/repository/level/level_repository.dart';
import 'package:mela/domain/repository/question/question_repository.dart';
import 'package:mela/domain/repository/setting/setting_repository.dart';
import 'package:mela/domain/repository/stat/stat_search_repository.dart';
import 'package:mela/domain/repository/topic_lecture/topic_lecture_repository.dart';

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

import '../../network/apis/stats/stats_api.dart';
import '../../repository/forgot_password/forgot_password_repository_impl.dart';
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
    getIt.registerSingleton<UserRepository>(UserRepositoryImpl(
        getIt<LogoutApi>(),
        getIt<UserInfoApi>(),
        getIt<DeleteAccountApi>(),
        getIt<SecureStorageHelper>(),
        getIt<SharedPreferenceHelper>()));

    //Setting:------------------------------------------------------------------
    getIt.registerSingleton<SettingRepository>(SettingRepositoryImpl(
      getIt<SharedPreferenceHelper>(),
    ));

    //Authenticate:-------------------------------------------------------------

    getIt.registerSingleton<UserLoginRepository>(UserLoginRepositoryImpl(
      getIt<SharedPreferenceHelper>(),
      getIt<SecureStorageHelper>(),
      getIt<LoginApi>(),
      getIt<RefreshAccessTokenApi>(),
    ));
    getIt.registerSingleton<UserSignUpRepository>(
        UserSignupRepositoryImpl(getIt<SignupApi>()));
    getIt.registerSingleton<ForgotPasswordRepository>(
        ForgotPasswordRepositoryImpl(getIt<ForgotPasswordApi>()));

    //Content Deli:-------------------------------------------------------------

    getIt.registerSingleton<TopicRepository>(
        TopicRepositoryImpl(getIt<TopicApi>()));
    getIt.registerSingleton<LevelRepository>(
        LevelRepositoryImpl(getIt<LevelApi>()));
    getIt.registerSingleton<TopicLectureRepository>(
        TopicLectureRepositoryImpl(getIt<TopicLectureApi>()));

    getIt.registerSingleton<LectureRepository>(
        LectureRepositoryImpl(getIt<LectureApi>()));

    getIt.registerSingleton<ExerciseRepository>(
        ExerciseRepositoryImpl(getIt<ExerciseApi>()));

    getIt.registerSingleton<SearchRepository>(
        SearchRepositoryImpl(getIt<SearchApi>(), getIt<HistoryDataSource>()));

    //STATS-------------------------
    getIt.registerSingleton<StatRepository>(
        StatRepositoryImpl(getIt<StatsApi>()));
    getIt.registerSingleton<StatSearchRepository>(
        StatSearchRepositoryImpl() as StatSearchRepository);

    //Practice De
    getIt.registerSingleton<QuestionRepository>(QuestionRepositoryImpl(
      getIt<QuestionsApi>(),
    ) as QuestionRepository);

    //ChatAI
    getIt.registerSingleton<ChatRepository>(ChatRepositoryImpl(
      getIt<ChatApi>(),
    ) as ChatRepository);
  }
}
