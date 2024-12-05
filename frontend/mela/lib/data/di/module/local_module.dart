import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mela/core/data/local/sembast/sembast_client.dart';
import 'package:mela/data/local/constants/db_constants.dart';
import 'package:mela/data/local/datasources/history_search/history_search_datasource.dart';
import 'package:mela/data/local/datasources/post/post_datasource.dart';
import 'package:mela/data/securestorage/secure_storage_helper.dart';
import 'package:mela/data/sharedpref/shared_preference_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../di/service_locator.dart';

class LocalModule {
  static Future<void> configureLocalModuleInjection() async {
    // preference manager:------------------------------------------------------
    getIt.registerSingletonAsync<SharedPreferences>(
        SharedPreferences.getInstance);
    getIt.registerSingleton<SharedPreferenceHelper>(
      SharedPreferenceHelper(await getIt.getAsync<SharedPreferences>()),
    );
    //Secure Storage:-----------------------------------------------------------
    getIt.registerSingleton<FlutterSecureStorage>(
      FlutterSecureStorage(),
    );
    getIt.registerSingleton<SecureStorageHelper>(
        SecureStorageHelper(getIt.get<FlutterSecureStorage>()));

    // database:----------------------------------------------------------------

    getIt.registerSingletonAsync<SembastClient>(
      () async => SembastClient.provideDatabase(
        databaseName: DBConstants.DB_NAME,
        databasePath: kIsWeb
            ? "/assets/db"
            : (await getApplicationDocumentsDirectory()).path,
      ),
    );

    // data sources:------------------------------------------------------------
    getIt.registerSingleton(
        PostDataSource(await getIt.getAsync<SembastClient>()));
    getIt.registerSingleton<HistoryDataSource>(
        HistoryDataSource(await getIt.getAsync<SembastClient>()));
  }
}
