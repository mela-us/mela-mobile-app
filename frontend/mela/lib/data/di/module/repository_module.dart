import 'dart:async';

import 'package:mela/data/repository/exercise/exercise_repository_impl.dart';
import 'package:mela/data/repository/lecture/lecture_repository_impl.dart';
import 'package:mela/domain/repository/exercise/exercise_repository.dart';
import 'package:mela/domain/repository/post/post_repository.dart';
import 'package:mela/domain/repository/setting/setting_repository.dart';
import 'package:mela/domain/repository/topic/topic_repository.dart';
import 'package:mela/domain/repository/user_login/user_login_repository.dart';
import 'package:mela/domain/repository/user_register/user_signup_repostiory.dart';

import '../../../di/service_locator.dart';
import '../../../domain/repository/lecture/lecture_repository.dart';
import '../../local/datasources/post/post_datasource.dart';
import '../../network/apis/posts/post_api.dart';
import '../../repository/post/post_repository_impl.dart';
import '../../repository/setting/setting_repository_impl.dart';
import '../../repository/topic/topic_repository_impl.dart';
import '../../repository/user_login/user_login_repository_impl.dart';
import '../../repository/user_signup/user_signup_repository_impl.dart';
import '../../sharedpref/shared_preference_helper.dart';

class RepositoryModule {
  static Future<void> configureRepositoryModuleInjection() async {
    // repository:--------------------------------------------------------------
    getIt.registerSingleton<SettingRepository>(SettingRepositoryImpl(
      getIt<SharedPreferenceHelper>(),
    ));

    getIt.registerSingleton<UserLoginRepository>(UserLoginRepositoryImpl(
      getIt<SharedPreferenceHelper>(),
    ));
    getIt.registerSingleton<UserSignUpRepository>(UserSignupRepositoryImpl());

    getIt.registerSingleton<PostRepository>(PostRepositoryImpl(
      getIt<PostApi>(),
      getIt<PostDataSource>(),
    ));
    getIt.registerSingleton<TopicRepository>(TopicRepositoryImpl());
    getIt.registerSingleton<LectureRepository>(LectureRepositoryImpl());
    getIt.registerSingleton<ExerciseRepository>(ExerciseRepositoryImpl());
  }
}
