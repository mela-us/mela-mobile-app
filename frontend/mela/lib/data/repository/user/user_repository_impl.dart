import 'dart:async';

import 'package:mela/domain/repository/user/user_repository.dart';
import 'package:mela/data/sharedpref/shared_preference_helper.dart';

import '../../../di/service_locator.dart';
import '../../../domain/entity/user/token_model.dart';
import '../../../domain/entity/user/user.dart';
import '../../../domain/entity/user/user.dart';
import '../../network/apis/user/logout_api.dart';
import '../../securestorage/secure_storage_helper.dart';

class UserRepositoryImpl extends UserRepository {

  LogoutApi _logoutApi;
  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  UserRepositoryImpl(this._logoutApi, this._sharedPrefsHelper);

  @override
  Future<User> getUserInfo() async {
    return User(
        id: '128736',
        name: 'Anh Long',
        email: 'anhlong@gmail.com',
        dob: '01/01/2003',
    );
  }

  @override
  Future<User> updateUserInfo(User newUser) {
    // TODO: implement updateUserInfo
    throw UnimplementedError();
  }

  @override
  Future<bool> logout() async {

    String accessToken = await getIt<SecureStorageHelper>().accessToken ?? "";
    String refreshToken = await getIt<SecureStorageHelper>().refreshToken ?? "";

    TokenModel tokens = TokenModel(
      accessToken: accessToken,
      refreshToken: refreshToken
    );
    return _logoutApi.logout(tokens);
  }
}
