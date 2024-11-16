import 'dart:async';

import 'package:mela/core/stores/error/error_store.dart';
import 'package:mela/core/stores/form/form_store.dart';
import 'package:mela/domain/repository/setting/setting_repository.dart';
import 'package:mela/domain/usecase/post/get_post_usecase.dart';
import 'package:mela/domain/usecase/stat/get_progress_usecase.dart';
import 'package:mela/domain/usecase/stat/get_detailed_progress_usecase.dart';
import 'package:mela/domain/usecase/user/is_logged_in_usecase.dart';
import 'package:mela/domain/usecase/user/login_usecase.dart';
import 'package:mela/domain/usecase/user/save_login_in_status_usecase.dart';
import 'package:mela/presentation/home/store/language/language_store.dart';
import 'package:mela/presentation/home/store/theme/theme_store.dart';
import 'package:mela/presentation/login/store/login_store.dart';
import 'package:mela/presentation/post/store/post_store.dart';
import 'package:mela/presentation/stats/store/stats_store.dart';
import 'package:mela/presentation/personal/store/personal_store.dart';

import '../../../di/service_locator.dart';
import '../../../domain/usecase/user/get_user_info_usecase.dart';

class StoreModule {
  static Future<void> configureStoreModuleInjection() async {
    // factories:---------------------------------------------------------------
    getIt.registerFactory(() => ErrorStore());
    getIt.registerFactory(() => FormErrorStore());
    getIt.registerFactory(
          () => FormStore(getIt<FormErrorStore>(), getIt<ErrorStore>()),
    );

    // stores:------------------------------------------------------------------
    getIt.registerSingleton<UserStore>(
      UserStore(
        getIt<IsLoggedInUseCase>(),
        getIt<SaveLoginStatusUseCase>(),
        getIt<LoginUseCase>(),
        getIt<FormErrorStore>(),
        getIt<ErrorStore>(),
      ),
    );

    getIt.registerSingleton<PostStore>(
      PostStore(
        getIt<GetPostUseCase>(),
        getIt<ErrorStore>(),
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