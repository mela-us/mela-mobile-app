import 'dart:async';

import 'package:http/http.dart';
import 'package:mela/core/stores/error/error_store.dart';
import 'package:mela/core/stores/form/form_store.dart';
import 'package:mela/domain/usecase/lecture/get_divided_lecture_usecase.dart';
import 'package:mela/domain/usecase/lecture/get_levels_usecase.dart';
import 'package:mela/domain/usecase/post/get_post_usecase.dart';
import 'package:mela/domain/usecase/question/get_questions_usecase.dart';
import 'package:mela/domain/usecase/user_login/save_access_token_usecase.dart';
import 'package:mela/domain/usecase/user_login/save_refresh_token_usecase.dart';
import 'package:mela/presentation/post/store/post_store.dart';


import 'package:mela/presentation/question/store/single_question/single_question_store.dart';
import 'package:mela/presentation/question/store/timer/timer_store.dart';

import '../../../di/service_locator.dart';
import '../../../domain/usecase/user/get_user_info_usecase.dart';
import '../../question/store/question_store.dart';
import 'package:mela/domain/usecase/exercise/get_exercises_usecase.dart';
import 'package:mela/domain/usecase/search/get_history_search_list.dart';
import 'package:mela/domain/usecase/search/get_search_lectures_result.dart';
import 'package:mela/presentation/courses_screen/store/topic_store/topic_store.dart';
import 'package:mela/presentation/divided_lectures_and_exercises_screen/store/exercise_store.dart';
import 'package:mela/presentation/filter_screen/store/filter_store.dart';
import 'package:mela/presentation/search_screen/store/search_store.dart';


import '../../../domain/usecase/lecture/get_lectures_are_learning_usecase.dart';
import '../../../domain/usecase/lecture/get_lectures_usecase.dart';

import '../../../domain/usecase/topic/get_topics_usecase.dart';
import '../../../domain/usecase/user_login/is_logged_in_usecase.dart';
import '../../../domain/usecase/user_login/login_usecase.dart';
import '../../../domain/usecase/user_login/save_login_in_status_usecase.dart';
import '../../../domain/usecase/user_signup/signup_usecase.dart';

import '../../lectures_in_topic_screen/store/lecture_store.dart';
import '../../signup_login_screen/store/login_or_signup_store/login_or_signup_store.dart';
import '../../signup_login_screen/store/user_login_store/user_login_store.dart';
import '../../signup_login_screen/store/user_signup_store/user_signup_store.dart';

import 'package:mela/domain/usecase/stat/get_progress_usecase.dart';
import 'package:mela/domain/usecase/stat/get_detailed_progress_usecase.dart';

import 'package:mela/presentation/stats/store/stats_store.dart';
import 'package:mela/presentation/personal/store/personal_store.dart';


class StoreModule {
  static Future<void> configureStoreModuleInjection() async {
    // factories:---------------------------------------------------------------
    getIt.registerFactory(() => ErrorStore());
    getIt.registerFactory(() => FormErrorStore());
    getIt.registerFactory(
      () => FormStore(getIt<FormErrorStore>(), getIt<ErrorStore>()),
    );

    // stores:------------------------------------------------------------------
    // getIt.registerSingleton<UserStore>(
    //   UserStore(
    //     getIt<IsLoggedInUseCase>(),
    //     getIt<SaveLoginStatusUseCase>(),
    //     getIt<LoginUseCase>(),
    //     getIt<FormErrorStore>(),
    //     getIt<ErrorStore>(),
    //   ),
    // );
    getIt.registerSingleton<PostStore>(PostStore(getIt<GetPostUseCase>(), getIt<ErrorStore>()));

    getIt.registerSingleton<UserLoginStore>(
      UserLoginStore(
        getIt<IsLoggedInUseCase>(),
        getIt<SaveLoginStatusUseCase>(),
        getIt<LoginUseCase>(),
        getIt<SaveAccessTokenUsecase>(),
        getIt<SaveRefreshTokenUsecase>(),
        getIt<ErrorStore>(),
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

    getIt.registerSingleton<LectureStore>(
      LectureStore(
        getIt<GetLecturesUsecase>(),
        getIt<GetLecturesAreLearningUsecase>(),
        getIt<GetLevelsUsecase>(),
        getIt<GetDividedLectureUsecase>(),
      ),
    );
    //After LectureStore because ExerciseStore use LectureStore
        getIt.registerSingleton<ExerciseStore>(
      ExerciseStore(getIt<GetExercisesUseCase>()),
    );

    getIt.registerSingleton<SearchStore>(SearchStore(
        getIt<GetHistorySearchList>(), getIt<GetSearchLecturesResult>()));
    getIt.registerSingleton<FilterStore>(FilterStore());

    //After LectureStore because TopicStore use LectureStore
    getIt.registerSingleton<TopicStore>(TopicStore(getIt<GetTopicsUsecase>()));


    getIt.registerSingleton<SingleQuestionStore>(
      SingleQuestionStore(
      )
    );

    getIt.registerSingleton<QuestionStore>(
      QuestionStore(
        getIt<GetQuestionsUseCase>(),
        getIt<ErrorStore>(),
      )
    );

    getIt.registerSingleton<TimerStore>(
     TimerStore()
    );

    getIt.registerSingleton<StatisticsStore>(
      StatisticsStore(
        getIt<GetProgressListUseCase>(),
        getIt<GetDetailedProgressListUseCase>(),
        getIt<ErrorStore>(),
      ),
    );

    getIt.registerSingleton<PersonalStore>(
      PersonalStore(
        getIt<GetUserInfoUseCase>(),
        getIt<ErrorStore>(),
      ),
    );

  }
}


