import 'dart:async';
import 'package:mela/core/stores/error/error_store.dart';
import 'package:mela/core/stores/form/form_store.dart';
import 'package:mela/domain/usecase/chat/create_new_conversation_usecase.dart';
import 'package:mela/domain/usecase/chat/delete_conversation_usecase.dart';
import 'package:mela/domain/usecase/chat/get_conversation_usecase.dart';
import 'package:mela/domain/usecase/chat/get_history_chat_usecase.dart';
import 'package:mela/domain/usecase/chat/get_token_chat_usecase.dart';
import 'package:mela/domain/usecase/chat/send_message_chat_usecase.dart';
import 'package:mela/domain/usecase/chat/send_message_get_solution_usecase.dart';
import 'package:mela/domain/usecase/chat/send_message_review_submission_usecase.dart';
import 'package:mela/domain/usecase/chat_with_exercise/send_message_chat_exercise_usecase.dart';
import 'package:mela/domain/usecase/chat_with_exercise/send_message_chat_pdf_usecase.dart';
import 'package:mela/domain/usecase/history/update_excercise_progress_usecase.dart';
import 'package:mela/domain/usecase/lecture/get_divided_lecture_usecase.dart';
import 'package:mela/domain/usecase/question/upload_images_usecase.dart';
import 'package:mela/domain/usecase/stat/get_detailed_progress_usecase.dart';
import 'package:mela/domain/usecase/suggestion/get_proposed_new_suggestion_usecase.dart';
import 'package:mela/domain/usecase/level/get_level_list_usecase.dart';
import 'package:mela/domain/usecase/question/generate_hint_usecase.dart';
import 'package:mela/domain/usecase/question/generate_term_usecase.dart';
import 'package:mela/domain/usecase/question/get_questions_usecase.dart';
import 'package:mela/domain/usecase/revise/get_revision_usecase.dart';
import 'package:mela/domain/usecase/revise/update_revision_usecase.dart';
import 'package:mela/domain/usecase/suggestion/update_suggestion_usecase.dart';
import 'package:mela/domain/usecase/topic_lecture/get_topic_lecture_usecase.dart';
import 'package:mela/domain/usecase/user/update_user_usecase.dart';
import 'package:mela/domain/usecase/user_login/login_with_google_usecase.dart';
import 'package:mela/domain/usecase/user_login/save_access_token_usecase.dart';
import 'package:mela/domain/usecase/user_login/save_refresh_token_usecase.dart';
import 'package:mela/presentation/chat/store/history_store.dart';
import 'package:mela/presentation/home_screen/store/level_store/level_store.dart';
import 'package:mela/presentation/home_screen/store/revise_store/revise_store.dart';
import 'package:mela/presentation/list_proposed_new_lecture/store/list_proposed_new_suggestion_store.dart';
import 'package:mela/presentation/question/store/hint_store/hint_store.dart';

import 'package:mela/presentation/question/store/single_question/single_question_store.dart';
import 'package:mela/presentation/question/store/timer/timer_store.dart';
import 'package:mela/presentation/stats_topic_personal/store/detailed_stats_store.dart';
import 'package:mela/presentation/thread_chat/store/chat_box_store/chat_box_store.dart';
import 'package:mela/presentation/thread_chat/store/thread_chat_store/thread_chat_store.dart';
import 'package:mela/presentation/thread_chat_learning/store/thread_chat_learning_store/thread_chat_learning_store.dart';
import 'package:mela/presentation/thread_chat_learning_pdf/store/chat_box_learning_pdf_store/chat_box_learning_pdf_store.dart';
import 'package:mela/presentation/thread_chat_learning_pdf/store/thread_chat_learning_pdf_store/thread_chat_learning_pdf_store.dart';
import 'package:mela/presentation/topic_lecture_in_level_screen/store/topic_lecture_store.dart';
import 'package:mela/presentation/tutor/stores/tutor_store.dart';

import '../../../di/service_locator.dart';
import '../../../domain/usecase/forgot_password/create_new_password_usecase.dart';
import '../../../domain/usecase/forgot_password/verify_exist_email_usecase.dart';
import '../../../domain/usecase/forgot_password/verify_otp_usecase.dart';
import '../../../domain/usecase/question/submit_result_usecase.dart';
import '../../../domain/usecase/search/add_history_search_usecase.dart';
import '../../../domain/usecase/search/delete_all_history_search_usecase.dart';
import '../../../domain/usecase/search/delete_history_search_usecase.dart';
import '../../../domain/usecase/stat/get_stat_search_history_usecase.dart';
import '../../../domain/usecase/stat/update_stat_search_history_usecase.dart';
import '../../../domain/usecase/streak/get_streak_usecase.dart';
import '../../../domain/usecase/streak/update_streak_usecase.dart';
import '../../../domain/usecase/user/delete_user_usecase.dart';
import '../../../domain/usecase/user/get_user_info_usecase.dart';
import '../../../domain/usecase/user/logout_usecase.dart';
import '../../forgot_password_screen/store/create_new_password_store/create_new_password_store.dart';
import '../../forgot_password_screen/store/enter_email_store/enter_email_store.dart';
import '../../forgot_password_screen/store/enter_otp_store.dart/enter_otp_store.dart';
import '../../question/store/question_store.dart';
import 'package:mela/domain/usecase/exercise/get_exercises_usecase.dart';
import 'package:mela/domain/usecase/search/get_history_search_list_usecase.dart';
import 'package:mela/domain/usecase/search/get_search_lectures_result_usecase.dart';
import 'package:mela/presentation/divided_lectures_and_exercises_screen/store/exercise_store.dart';
import 'package:mela/presentation/filter_screen/store/filter_store.dart';
import 'package:mela/presentation/search_screen/store/search_store.dart';

import '../../../domain/usecase/lecture/get_lectures_are_learning_usecase.dart';

import '../../../domain/usecase/topic/get_topics_usecase.dart';
import '../../../domain/usecase/user_login/is_logged_in_usecase.dart';
import '../../../domain/usecase/user_login/login_usecase.dart';
import '../../../domain/usecase/user_login/save_login_in_status_usecase.dart';
import '../../../domain/usecase/user_signup/signup_usecase.dart';

import '../../signup_login_screen/store/login_or_signup_store/login_or_signup_store.dart';
import '../../signup_login_screen/store/user_login_store/user_login_store.dart';
import '../../signup_login_screen/store/user_signup_store/user_signup_store.dart';

import 'package:mela/domain/usecase/stat/get_progress_usecase.dart';

import 'package:mela/presentation/stats_history/store/stats_store.dart';
import 'package:mela/presentation/personal/store/personal_store.dart';

import '../../stats_history/store/stat_filter_store.dart';
import '../../stats_history/store/stat_search_store.dart';

import '../../streak/store/streak_store.dart';
import '../../thread_chat_learning/store/chat_box_learning_store/chat_box_learning_store.dart';

class StoreModule {
  static Future<void> configureStoreModuleInjection() async {
    // factories:---------------------------------------------------------------
    getIt.registerFactory(() => ErrorStore());
    getIt.registerFactory(() => FormErrorStore());
    getIt.registerFactory(
      () => FormStore(getIt<FormErrorStore>(), getIt<ErrorStore>()),
    );

    // stores:------------------------------------------------------------------

    //UserLoginStore
    getIt.registerSingleton<UserLoginStore>(
      UserLoginStore(
        getIt<IsLoggedInUseCase>(),
        getIt<SaveLoginStatusUseCase>(),
        getIt<LoginUseCase>(),
        getIt<SaveAccessTokenUsecase>(),
        getIt<SaveRefreshTokenUsecase>(),
        getIt<LoginWithGoogleUseCase>(),
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

    //After LectureStore because ExerciseStore use LectureStore
    getIt.registerSingleton<ExerciseStore>(
      ExerciseStore(
          getIt<GetExercisesUseCase>(), getIt<GetDividedLectureUsecase>()),
    );

    //LevelStore: -----------------------------------------------------------------
    getIt.registerSingleton<LevelStore>(
      LevelStore(
        getIt<GetLevelListUsecase>(),
        getIt<GetLecturesAreLearningUsecase>(),
        getIt<GetTopicsUsecase>(),
      ),
    );

    //TopicLectureStore:-----------------------------------------------------------------
    getIt.registerSingleton<TopicLectureStore>(
      TopicLectureStore(
        getIt<GetTopicLectureUsecase>(),
      ),
    );

    //SearchStore:-----------------------------------------------------------------
    getIt.registerSingleton<SearchStore>(SearchStore(
      getIt<GetHistorySearchListUsecase>(),
      getIt<GetSearchLecturesResultUsecase>(),
      getIt<AddHistorySearchUsecase>(),
      getIt<DeleteAllHistorySearchUsecase>(),
      getIt<DeleteHistorySearchUsecase>(),
    ));
    getIt.registerSingleton<FilterStore>(FilterStore());

    //QuestionStore
    getIt.registerSingleton<SingleQuestionStore>(SingleQuestionStore());

    getIt.registerSingleton<QuestionStore>(QuestionStore(
      getIt<GetQuestionsUseCase>(),
      getIt<ErrorStore>(),
      getIt<SubmitResultUseCase>(),
      getIt<UpdateExcerciseProgressUsecase>(),
      getIt<SingleQuestionStore>(),
      getIt<UploadImagesUsecase>(),
    ));

    getIt.registerSingleton<TimerStore>(TimerStore());

    //StatisticsStore
    getIt.registerSingleton<StatisticsStore>(
      StatisticsStore(
        getIt<GetProgressListUseCase>(),
        getIt<GetLevelListUsecase>(),
        getIt<ErrorStore>(),
      ),
    );

    getIt.registerSingleton<DetailedStatStore>(
      DetailedStatStore(
        getIt<GetDetailedStatsUseCase>(),
        getIt<ErrorStore>(),
      ),
    );

    //PersonalStore
    getIt.registerSingleton<PersonalStore>(
      PersonalStore(
        getIt<GetUserInfoUseCase>(),
        getIt<LogoutUseCase>(),
        getIt<ErrorStore>(),
        getIt<UpdateUserUsecase>(),
        getIt<DeleteAccountUseCase>(),
      ),
    );

    //Forgot password
    getIt.registerSingleton<EnterEmailStore>(
        EnterEmailStore(getIt<VerifyExistEmailUseCase>()));
    getIt.registerSingleton<EnterOTPStore>(
        EnterOTPStore(getIt<VerifyOTPUseCase>()));
    getIt.registerSingleton<CreateNewPasswordStore>(
        CreateNewPasswordStore(getIt<CreateNewPasswordUsecase>()));

    getIt.registerSingleton<StatSearchStore>(
      StatSearchStore(
        getIt<GetStatSearchHistoryUseCase>(),
        getIt<UpdateStatSearchHistoryUseCase>(),
      ),
    );

    //StatFilterStore
    getIt.registerSingleton<StatFilterStore>(
      StatFilterStore(),
    );

    //ChatBotStore
    getIt.registerSingleton<ChatBoxStore>(
      ChatBoxStore(),
    );
    getIt.registerSingleton<ThreadChatStore>(ThreadChatStore(
      getIt<SendMessageChatUsecase>(),
      getIt<GetConversationUsecase>(),
      getIt<CreateNewConversationUsecase>(),
      getIt<SendMessageReviewSubmissionUsecase>(),
      getIt<SendMessageGetSolutionUsecase>(),
      getIt<GetTokenChatUsecase>(),
    ));

    //Hint Store
    getIt.registerSingleton<HintStore>(
        HintStore(getIt<GenerateHintUseCase>(), getIt<GenerateTermUseCase>()));

    //History
    getIt.registerSingleton<HistoryStore>(HistoryStore(
        getIt<GetHistoryChatUsecase>(),
        getIt<ErrorStore>(),
        getIt<DeleteConversationUsecase>()));

    getIt.registerSingleton<TutorStore>(TutorStore(
      getIt<GetLevelListUsecase>(),
    ));

    //Streak
    getIt.registerSingleton<StreakStore>(StreakStore(
      getIt<ErrorStore>(),
      getIt<GetStreakUseCase>(),
      getIt<UpdateStreakUseCase>(),
    ));

    getIt.registerSingleton<ThreadChatLearningStore>(
      ThreadChatLearningStore(
        getIt<GetTokenChatUsecase>(),
        getIt<SendMessageChatExerciseUsecase>(),
      ),
    );
    getIt.registerSingleton<ChatBoxLearningStore>(ChatBoxLearningStore());
    getIt.registerSingleton<ThreadChatLearningPdfStore>(
      ThreadChatLearningPdfStore(
        getIt<GetTokenChatUsecase>(),
        getIt<SendMessageChatPdfUsecase>(),
      ),
    );
    getIt.registerSingleton<ChatBoxLearningPdfStore>(ChatBoxLearningPdfStore());
    getIt.registerSingleton<ListProposedNewSuggestionStore>(
        ListProposedNewSuggestionStore(getIt<GetProposedNewSuggestionUsecase>(),
            getIt<UpdateSuggestionUsecase>()));

    getIt.registerSingleton<ReviseStore>(
      ReviseStore(
        getIt<GetRevisionUsecase>(),
        getIt<UpdateRevisionUsecase>(),
      ),
    );
  }
}
