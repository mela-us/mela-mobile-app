import 'dart:async';

import 'package:mela/domain/usecase/exercise/get_exercises_usecase.dart';
import 'package:mela/domain/usecase/search/get_history_search_list.dart';
import 'package:mela/domain/usecase/search/get_search_lectures_result.dart';
import 'package:mela/presentation/courses_screen/store/topic_store/topic_store.dart';
import 'package:mela/presentation/divided_lectures_and_exercises_screen/store/exercise_store.dart';
import 'package:mela/presentation/post/store/post_store.dart';
import 'package:mela/presentation/search_screen/store/search_store.dart';

import '../../../core/stores/error/error_store.dart';
import '../../../core/stores/form/form_store.dart';
import '../../../di/service_locator.dart';
import '../../../domain/repository/setting/setting_repository.dart';
import '../../../domain/usecase/lecture/get_lectures_usecase.dart';
import '../../../domain/usecase/post/get_post_usecase.dart';
import '../../../domain/usecase/topic/get_topics_usecase.dart';
import '../../../domain/usecase/user_login/is_logged_in_usecase.dart';
import '../../../domain/usecase/user_login/login_usecase.dart';
import '../../../domain/usecase/user_login/save_login_in_status_usecase.dart';
import '../../../domain/usecase/user_signup/signup_usecase.dart';
import '../../courses_screen/store/theme_store/theme_store.dart';
import '../../home/store/language/language_store.dart';
import '../../lectures_in_topic_screen/store/lecture_store.dart';
import '../../signup_login_screen/store/login_or_signup_store/login_or_signup_store.dart';
import '../../signup_login_screen/store/user_login_store/user_login_store.dart';
import '../../signup_login_screen/store/user_signup_store/user_signup_store.dart';

class StoreModule {
  static Future<void> configureStoreModuleInjection() async {
    // factories:---------------------------------------------------------------
    getIt.registerFactory(() => ErrorStore());
    getIt.registerFactory(() => FormErrorStore());
    getIt.registerFactory(
      () => FormStore(getIt<FormErrorStore>(), getIt<ErrorStore>()),
    );

    // stores:------------------------------------------------------------------
    getIt.registerSingleton<UserLoginStore>(
      UserLoginStore(
        getIt<IsLoggedInUseCase>(),
        getIt<SaveLoginStatusUseCase>(),
        getIt<LoginUseCase>(),
      ),
    );
    //UserSignupStore
    getIt.registerSingleton<UserSignupStore>(
      UserSignupStore(
        getIt<SignupUseCase>(),
      ),
    );

    getIt.registerSingleton<LoginOrSignupStore>(
      LoginOrSignupStore(),
    );
    getIt.registerSingleton<ExerciseStore>(
      ExerciseStore(getIt<GetExercisesUseCase>()),
    );
    getIt.registerSingleton<SearchStore>(
        SearchStore(getIt<GetHistorySearchList>(),getIt<GetSearchLecturesResult>()));

    getIt.registerSingleton<PostStore>(
      PostStore(
        getIt<GetPostUseCase>(),
        getIt<ErrorStore>(),
      ),
    );
    getIt.registerSingleton<TopicStore>(TopicStore(getIt<GetTopicsUsecase>()));

    getIt.registerSingleton<LectureStore>(
      LectureStore(
        getIt<GetLecturesUsecase>(),
      ),
    );

    getIt.registerSingleton<ThemeStore>(
      ThemeStore(
        getIt<SettingRepository>(),
        getIt<ErrorStore>(),
      ),
    );

    getIt.registerSingleton<LanguageStore>(
      LanguageStore(
        getIt<SettingRepository>(),
        getIt<ErrorStore>(),
      ),
    );
  }
}
