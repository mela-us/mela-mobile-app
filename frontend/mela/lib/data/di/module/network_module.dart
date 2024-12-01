import 'package:event_bus/event_bus.dart';
import 'package:mela/data/network/apis/questions/questions_api.dart';
import 'package:mela/data/network/apis/questions/save_result_api.dart';

import '../../../core/data/network/constants/network_constants.dart';
import '../../../core/data/network/dio/configs/dio_configs.dart';
import '../../../core/data/network/dio/interceptors/auth_interceptor.dart';
import '../../../core/data/network/dio/interceptors/logging_interceptor.dart';
import '../../../di/service_locator.dart';
import '../../network/dio_client.dart';
import '../../network/interceptors/error_interceptor.dart';
import '../../network/rest_client.dart';
import '../../sharedpref/shared_preference_helper.dart';

class NetworkModule {
  static Future<void> configureNetworkModuleInjection() async {
    // event bus:---------------------------------------------------------------
    getIt.registerSingleton<EventBus>(EventBus());

    // interceptors:------------------------------------------------------------
    getIt.registerSingleton<LoggingInterceptor>(LoggingInterceptor());
    getIt.registerSingleton<ErrorInterceptor>(ErrorInterceptor(getIt()));
    getIt.registerSingleton<AuthInterceptor>(
      AuthInterceptor(
        accessToken: () async => await getIt<SharedPreferenceHelper>().authToken,
      ),
    );

    // rest client:-------------------------------------------------------------
    getIt.registerSingleton(RestClient());

    // dio:---------------------------------------------------------------------
    getIt.registerSingleton<DioConfigs>(
      const DioConfigs(
        baseUrl: NetworkConstants.baseUrl,
        connectionTimeout: NetworkConstants.connectionTimeout,
        receiveTimeout: NetworkConstants.receiveTimeout,
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
    getIt.registerSingleton(QuestionsApi(getIt<DioClient>()));
    getIt.registerSingleton(SaveResultApi(getIt<DioClient>()));
  }
}
