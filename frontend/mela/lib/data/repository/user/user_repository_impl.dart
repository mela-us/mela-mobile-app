import 'dart:async';

import 'package:mela/data/network/apis/user/user_info_api.dart';
import 'package:mela/domain/repository/user/user_repository.dart';
import 'package:mela/data/sharedpref/shared_preference_helper.dart';

import '../../../di/service_locator.dart';
import '../../../domain/entity/user/token_model.dart';
import '../../../domain/entity/user/user.dart';
import '../../../domain/entity/user/user.dart';
import '../../network/apis/user/logout_api.dart';
import '../../securestorage/secure_storage_helper.dart';

class UserRepositoryImpl extends UserRepository {

  final LogoutApi _logoutApi;
  final UserInfoApi _userInfoApi;
  // shared pref object
  final SecureStorageHelper _secureStorageHelper;

  // constructor
  UserRepositoryImpl(this._logoutApi, this._userInfoApi, this._secureStorageHelper);

  @override
  Future<User> getUserInfo() async {
    // return User(
    //     id: '128736',
    //     name: 'Anh Long',
    //     email: 'anhlong@gmail.com',
    //     dob: '01/01/2003',
    // );
    return _userInfoApi.getUser();
  }

  @override
  Future<User> updateUserInfo(User newUser) {
    // TODO: implement updateUserInfo
    throw UnimplementedError();
  }

  @override
  Future<bool> logout() async {

    String accessToken = await _secureStorageHelper.accessToken ?? "";
    String refreshToken = await _secureStorageHelper.refreshToken ?? "";

    TokenModel tokens = TokenModel(
      accessToken: accessToken,
      refreshToken: refreshToken
    );
    //delete accessTokens and refreshToken
    await _secureStorageHelper.saveAccessToken("");
    await _secureStorageHelper.saveRefreshToken("");

    return _logoutApi.logout(tokens);
  }
}
