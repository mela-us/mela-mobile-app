import 'dart:async';

import 'package:mela/data/local/datasources/post/post_datasource.dart';
import 'package:mela/data/network/apis/posts/post_api.dart';
import 'package:mela/data/repository/post/post_repository_impl.dart';
import 'package:mela/data/repository/question/question_repository_impl.dart';
import 'package:mela/data/repository/setting/setting_repository_impl.dart';
import 'package:mela/data/repository/user/user_repository_impl.dart';
import 'package:mela/data/sharedpref/shared_preference_helper.dart';
import 'package:mela/domain/repository/post/post_repository.dart';
import 'package:mela/domain/repository/question/question_repository.dart';
import 'package:mela/domain/repository/setting/setting_repository.dart';
import 'package:mela/domain/repository/user/user_repository.dart';

import '../../../di/service_locator.dart';

class RepositoryModule {
  static Future<void> configureRepositoryModuleInjection() async {
    // repository:--------------------------------------------------------------
    getIt.registerSingleton<SettingRepository>(SettingRepositoryImpl(
      getIt<SharedPreferenceHelper>(),
    ) as SettingRepository);

    getIt.registerSingleton<UserRepository>(UserRepositoryImpl(
      getIt<SharedPreferenceHelper>(),
    ) as UserRepository);

    getIt.registerSingleton<PostRepository>(PostRepositoryImpl(
      getIt<PostApi>(),
      getIt<PostDataSource>(),
    ) as PostRepository);

    getIt.registerSingleton<QuestionRepository>(
        QuestionRepositoryImpl() as QuestionRepository);
  }
}
