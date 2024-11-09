import 'dart:async';

import 'package:mela/domain/usecase/user/login_usecase.dart';

import '../../../domain/entity/user/user.dart';
import '../../../domain/repository/user/user_repository.dart';
import '../../sharedpref/shared_preference_helper.dart';


class UserRepositoryImpl extends UserRepository {
  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  UserRepositoryImpl(this._sharedPrefsHelper);

  // Login:---------------------------------------------------------------------
  @override
  Future<User?> login(LoginParams params) async {
    try {
      // TODO: implement login
      return await Future.delayed(Duration(seconds: 5), () => User(accessToken: "abc", username: "abc@gmail.com",  password: "abc"));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> saveIsLoggedIn(bool value) =>
      _sharedPrefsHelper.saveIsLoggedIn(value);

  @override
  Future<bool> get isLoggedIn => _sharedPrefsHelper.isLoggedIn;
}
