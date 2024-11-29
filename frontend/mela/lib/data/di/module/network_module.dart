import 'package:event_bus/event_bus.dart';
import 'package:mela/data/network/apis/exercises/exercise_api.dart';
import 'package:mela/data/network/apis/login_signup/login_api.dart';
import 'package:mela/data/network/apis/login_signup/refresh_access_token_api.dart';
import 'package:mela/data/network/apis/topics/topic_api.dart';
import 'package:mela/data/network/dio_client.dart';
import 'package:mela/data/securestorage/secure_storage_helper.dart';

import '../../../core/data/network/dio/configs/dio_configs.dart';
import '../../../core/data/network/dio/interceptors/auth_interceptor.dart';
import '../../../core/data/network/dio/interceptors/logging_interceptor.dart';
import '../../../di/service_locator.dart';
import '../../network/apis/lectures/lecture_api.dart';
import '../../network/apis/login_signup/signup_api.dart';
import '../../network/apis/posts/post_api.dart';
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
            //getIt<LoggingInterceptor>(),
          ],
        ),
    );

    // api's:-------------------------------------------------------------------
    getIt.registerSingleton(PostApi(getIt<DioClient>(), getIt<RestClient>()));
    getIt.registerSingleton<LoginApi>(LoginApi(getIt<DioClient>()));
    getIt.registerSingleton<SignupApi>(SignupApi(getIt<DioClient>()));
    getIt.registerSingleton<RefreshAccessTokenApi>(
        RefreshAccessTokenApi(getIt<DioClient>()));
    getIt.registerSingleton<TopicApi>(TopicApi(getIt<DioClient>()));
    getIt.registerSingleton<LectureApi>(LectureApi(getIt<DioClient>()));
    getIt.registerSingleton<ExerciseApi>(ExerciseApi(getIt<DioClient>()));
  }
}
