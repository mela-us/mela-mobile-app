import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:mela/data/network/apis/user/user_info_api.dart';
import 'package:mela/domain/repository/user/user_repository.dart';
import 'package:mela/data/sharedpref/shared_preference_helper.dart';

import '../../../domain/entity/user/token_model.dart';
import '../../../domain/entity/user/user.dart';
// ignore: duplicate_import
import '../../../domain/entity/user/user.dart';
import '../../network/apis/user/delete_account_api.dart';
import '../../network/apis/user/logout_api.dart';
import '../../securestorage/secure_storage_helper.dart';

class UserRepositoryImpl extends UserRepository {

  final LogoutApi _logoutApi;
  final UserInfoApi _userInfoApi;
  final DeleteAccountApi _deleteAccountApi;
  // shared pref object
  final SecureStorageHelper _secureStorageHelper;
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  UserRepositoryImpl(this._logoutApi, this._userInfoApi, this._deleteAccountApi, this._secureStorageHelper, this._sharedPrefsHelper);

  @override
  Future<User> getUserInfo() async {
    return _userInfoApi.getUser();
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
    await _sharedPrefsHelper.saveIsLoggedIn(false);

    return _logoutApi.logout(tokens);
  }

  @override
  Future<String> updateBirthday(String birthday) async {
    return _userInfoApi.updateBirthday(birthday);
  }

  @override
  Future<String> updateImage(File image, String uploadUrl) async{
    var request = await http.put(
      Uri.parse(uploadUrl),
      body: image.readAsBytesSync(),
      headers: {
        'Content-Type': 'image/jpeg',
      },
    );
    if (request.statusCode == 200) {
      return _userInfoApi.updateImage(image, uploadUrl);
    }
    else {
      throw Exception("Failed to upload image: ${request.statusCode}");
    }
  }

  @override
  Future<String> updateName(String name) {
    return _userInfoApi.updateName(name);
  }

  @override
  Future<String> getImageUpdatePresign() {
    return _userInfoApi.getImageUpdatePresign();
  }

  @override
  Future<bool> deleteAccount() async {
    //CLEAR TOKENS JUST LIKE LOGGING OUT
    String accessToken = await _secureStorageHelper.accessToken ?? "";
    String refreshToken = await _secureStorageHelper.refreshToken ?? "";

    TokenModel tokens = TokenModel(
        accessToken: accessToken,
        refreshToken: refreshToken
    );

    return await _deleteAccountApi.deleteAccount(tokens);
  }
}
