import 'dart:async';

import 'package:mela/data/network/apis/user/logout_api.dart';
import 'package:mela/data/repository/question/question_repository_impl.dart';
import 'package:mela/data/repository/setting/setting_repository_impl.dart';
import 'package:mela/data/repository/stat/stat_search_impl.dart';
import 'package:mela/data/securestorage/secure_storage_helper.dart';
import 'package:mela/data/sharedpref/shared_preference_helper.dart';
import 'package:mela/domain/entity/topic/topic.dart';
import 'package:mela/domain/repository/question/question_repository.dart';
import 'package:mela/domain/repository/setting/setting_repository.dart';
import 'package:mela/domain/repository/stat/stat_search_repository.dart';

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

import '../../network/apis/exercises/exercise_api.dart';
import '../../network/apis/lectures/lecture_api.dart';
import '../../network/apis/login_signup/login_api.dart';
import '../../network/apis/login_signup/refresh_access_token_api.dart';
import '../../network/apis/login_signup/signup_api.dart';
import '../../network/apis/searchs/search_api.dart';
import '../../network/apis/stats/stats_api.dart';
import '../../network/apis/topics/topic_api.dart';
import '../../repository/topic/topic_repository_impl.dart';
import '../../repository/user_login/user_login_repository_impl.dart';
import '../../repository/user_signup/user_signup_repository_impl.dart';
import 'package:mela/data/local/datasources/post/post_datasource.dart';
import 'package:mela/data/network/apis/posts/post_api.dart';
import 'package:mela/data/repository/post/post_repository_impl.dart';
import 'package:mela/data/repository/setting/setting_repository_impl.dart';
import 'package:mela/data/repository/user/user_repository_impl.dart';
import 'package:mela/data/sharedpref/shared_preference_helper.dart';
import 'package:mela/domain/repository/post/post_repository.dart';
import 'package:mela/domain/repository/setting/setting_repository.dart';
import 'package:mela/domain/repository/stat/stat_repository.dart';
import 'package:mela/domain/repository/user/user_repository.dart';

import '../../../di/service_locator.dart';
import '../../repository/stat/stat_repository_impl.dart';

class RepositoryModule {
  static Future<void> configureRepositoryModuleInjection() async {
    // repository:--------------------------------------------------------------
    getIt.registerSingleton<PostRepository>(PostRepositoryImpl(
      getIt<PostApi>(),
      getIt<PostDataSource>(),
    ));
    //UserInfor:
    getIt.registerSingleton<UserRepository>(
        UserRepositoryImpl(getIt<LogoutApi>(), getIt<SharedPreferenceHelper>())
    );

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

    //Content Deli:-------------------------------------------------------------

    getIt.registerSingleton<TopicRepository>(
        TopicRepositoryImpl(getIt<TopicApi>()));

    getIt.registerSingleton<LectureRepository>(
        LectureRepositoryImpl(getIt<LectureApi>()));

    getIt.registerSingleton<ExerciseRepository>(
        ExerciseRepositoryImpl(getIt<ExerciseApi>()));

    getIt.registerSingleton<SearchRepository>(
        SearchRepositoryImpl(getIt<SearchApi>()));

    //STATS-------------------------
    getIt.registerSingleton<StatRepository>(
        StatRepositoryImpl(getIt<StatsApi>()));
    getIt.registerSingleton<StatSearchRepository>(
        StatSearchRepositoryImpl() as StatSearchRepository);

    //Practice De
    getIt.registerSingleton<QuestionRepository>(
        QuestionRepositoryImpl() as QuestionRepository);
  }
}
