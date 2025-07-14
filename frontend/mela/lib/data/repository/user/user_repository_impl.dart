import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';

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
    User user = await _userInfoApi.getUser();
    return user;
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
  Future<String> updateImage(File image, String urls) async{
    //
    String contentType = lookupMimeType(image.path) ?? "application/octet-stream";
    //get urls
    List<String> separated = urls.split(" ");
    final uploadUrl = separated[0];
    final imageUrl = separated[1];
    print("UploadURL: $uploadUrl");
    print("ImageURL: $imageUrl");
    //
    var request = await http.put(
      Uri.parse(uploadUrl),
      body: await image.readAsBytes(),
      headers: {
        'x-ms-blob-type': 'BlockBlob',
        'Content-Type': contentType
        //'Content-Type': 'image/jpeg',
      },
    );
    print(request.body.toString());
    if (request.statusCode == 200 || request.statusCode == 201) {
      return _userInfoApi.updateImage(image, imageUrl);
    }
    else {
      throw Exception("Failed to upload image: ${request.statusCode}");
    }
  }

  @override
  Future<String> updateName(String name) async {
    return _userInfoApi.updateName(name);
  }

  @override
  Future<String> updateLevel(String level) async {
    return _userInfoApi.updateLevel(level);
  }

  @override
  Future<String> getImageUpdatePresign() async {
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
