import 'dart:async';

import 'package:mela/data/securestorage/secure_storage_helper.dart';
import 'package:mela/domain/entity/user/token_model.dart';
import 'package:mela/domain/usecase/user_login/login_usecase.dart';

import '../../../domain/repository/user_login/user_login_repository.dart';
import '../../sharedpref/shared_preference_helper.dart';

class UserLoginRepositoryImpl extends UserLoginRepository {
  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;
  final SecureStorageHelper _secureStorageHelper;

  // constructor
  UserLoginRepositoryImpl(this._sharedPrefsHelper, this._secureStorageHelper);

  // Login:---------------------------------------------------------------------
  @override
  Future<TokenModel?> login(LoginParams params) async {
    // try {
    //   // Step 1: Make API call
    //   final response = await http.post(
    //     Uri.parse('https://yourapi.com/login'), // Replace with your API endpoint
    //     body: {
    //       'username': params.username,
    //       'password': params.password,
    //     },
    //   );

    //   // Step 2: Check if statusCode is 200
    //   if (response.statusCode == 200) {
    //     // If statusCode is 200, parse the response and return a User object
    //     final Map<String, dynamic> data = json.decode(response.body);
    //     final String accessToken = data['accessToken'];
    //     final String username = data['username'];

    //     return User(accessToken: accessToken, username: username);
    //   } else {
    //     // If statusCode is not 200, throw an exception with the message
    //     final Map<String, dynamic> data = json.decode(response.body);
    //     final String message = data['message'] ?? 'Unknown error';
    //     throw Exception(message); // Throw the exception with the message from API
    //   }
    // } catch (e) {
    //   // Step 3: Catch any exceptions and rethrow them
    //   throw Exception('Login failed: ${e.toString()}');
    // }

    try {
      return await Future.delayed(
          Duration(seconds: 5),
          () =>
              TokenModel(accessToken: "abcd", refreshToken: "adasdadadddsd"));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> saveIsLoggedIn(bool value) =>
      _sharedPrefsHelper.saveIsLoggedIn(value);

  @override
  Future<bool> get isLoggedIn => _sharedPrefsHelper.isLoggedIn;
  
  @override
  Future<void> saveAccessToken(String accessToken) {
    return _secureStorageHelper.saveAccessToken(accessToken);
  }
  
  @override
  Future<void> saveRefreshToken(String refreshToken) {
    return _secureStorageHelper.saveRefreshToken(refreshToken);
  }
}
