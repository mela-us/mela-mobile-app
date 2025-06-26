import 'package:event_bus/event_bus.dart';
import 'package:mela/data/network/apis/chat/chat_api.dart';
import 'package:mela/data/network/apis/exercises/exercise_api.dart';
import 'package:mela/data/network/apis/history/update_progress_api.dart';
import 'package:mela/data/network/apis/level/level_api.dart';
import 'package:mela/data/network/apis/login_signup/login_api.dart';
import 'package:mela/data/network/apis/login_signup/refresh_access_token_api.dart';
import 'package:mela/data/network/apis/presigned_image/presigned_image_api.dart';
import 'package:mela/data/network/apis/presigned_image/presigned_image_upload_api.dart';
import 'package:mela/data/network/apis/questions/hint_api.dart';
import 'package:mela/data/network/apis/revise/revise_api.dart';
import 'package:mela/data/network/apis/searchs/search_api.dart';
import 'package:mela/data/network/apis/topic_lecture/topic_lecture_api.dart';
import 'package:mela/data/network/apis/topics/topic_api.dart';
import 'package:mela/data/network/apis/user/delete_account_api.dart';
import 'package:mela/data/network/dio_client.dart';
import 'package:mela/data/securestorage/secure_storage_helper.dart';

import '../../../core/data/network/dio/configs/dio_configs.dart';
import '../../../core/data/network/dio/interceptors/auth_interceptor.dart';
import '../../../core/data/network/dio/interceptors/logging_interceptor.dart';
import '../../../di/service_locator.dart';
import '../../network/apis/forgot_password/forgot_password_api.dart';
import '../../network/apis/lectures/lecture_api.dart';
import '../../network/apis/login_signup/signup_api.dart';
import '../../network/apis/questions/questions_api.dart';
import '../../network/apis/questions/save_result_api.dart';
import '../../network/apis/stats/stats_api.dart';
import '../../network/apis/streak/streak_api.dart';
import '../../network/apis/user/logout_api.dart';
import '../../network/apis/user/user_info_api.dart';
import '../../network/constants/endpoints_const.dart';
import '../../network/interceptors/error_interceptor.dart';
import '../../network/rest_client.dart';

class NetworkModule {
  static Future<void> configureNetworkModuleInjection() async {
    // event bus:---------------------------------------------------------------
    getIt.registerSingleton<EventBus>(EventBus());

    // interceptors:------------------------------------------------------------
    getIt.registerSingleton<LoggingInterceptor>(LoggingInterceptor());
    getIt.registerSingleton<ErrorInterceptor>(ErrorInterceptor(getIt()));
    getIt.registerSingleton<AuthInterceptor>(
      AuthInterceptor(
        accessToken: () async => await getIt<SecureStorageHelper>().accessToken,
      ),
    );

    // rest client:-------------------------------------------------------------
    getIt.registerSingleton(RestClient());

    // dio:---------------------------------------------------------------------
    getIt.registerSingleton<DioConfigs>(
      const DioConfigs(
        baseUrl: EndpointsConst.baseUrl,
        connectionTimeout: EndpointsConst.connectionTimeout,
        receiveTimeout: EndpointsConst.receiveTimeout,
      ),
    );
    getIt.registerSingleton<DioClient>(
      DioClient(dioConfigs: getIt())
        ..addInterceptors(
          [
            getIt<AuthInterceptor>(),
            getIt<ErrorInterceptor>(),
            getIt<LoggingInterceptor>(),
          ],
        ),
    );

    // api's:-------------------------------------------------------------------
    getIt.registerSingleton<LoginApi>(LoginApi(getIt<DioClient>()));
    getIt.registerSingleton<SignupApi>(SignupApi(getIt<DioClient>()));
    getIt.registerSingleton<RefreshAccessTokenApi>(
        RefreshAccessTokenApi(getIt<DioClient>()));
    getIt.registerSingleton<TopicApi>(TopicApi(getIt<DioClient>()));
    getIt.registerSingleton<LevelApi>(LevelApi(getIt<DioClient>()));
    getIt.registerSingleton<TopicLectureApi>(
        TopicLectureApi(getIt<DioClient>()));
    getIt.registerSingleton<LectureApi>(LectureApi(getIt<DioClient>()));
    getIt.registerSingleton<ExerciseApi>(ExerciseApi(getIt<DioClient>()));
    getIt.registerSingleton<SearchApi>(SearchApi(getIt<DioClient>()));
    getIt.registerSingleton(QuestionsApi(getIt<DioClient>()));
    getIt.registerSingleton(SaveResultApi(getIt<DioClient>()));
    getIt.registerSingleton<ForgotPasswordApi>(
        ForgotPasswordApi(getIt<DioClient>()));
    getIt.registerSingleton<StatsApi>(StatsApi(getIt<DioClient>()));
    getIt.registerSingleton<UserInfoApi>(UserInfoApi(getIt<DioClient>()));
    getIt.registerSingleton<LogoutApi>(LogoutApi(getIt<DioClient>()));
    getIt.registerSingleton<DeleteAccountApi>(
        DeleteAccountApi(getIt<DioClient>()));
    getIt.registerSingleton<ChatApi>(
        ChatApi(getIt<DioClient>(), getIt<SecureStorageHelper>()));
    getIt.registerSingleton<PresignedImageApi>(
        PresignedImageApi(getIt<DioClient>()));
    getIt.registerSingleton<PresignedImageUploadApi>(PresignedImageUploadApi());

    getIt.registerSingleton<HintApi>(HintApi(getIt<DioClient>()));
    getIt.registerSingleton<UpdateProgressApi>(
        UpdateProgressApi(getIt<DioClient>()));

    getIt.registerSingleton<StreakApi>(StreakApi(getIt<DioClient>()));

    getIt.registerSingleton<ReviseApi>(ReviseApi(getIt<DioClient>()));
  }
}
