import 'dart:async';

import 'package:mela/domain/repository/user/user_repository.dart';
import 'package:mela/data/sharedpref/shared_preference_helper.dart';

import '../../../domain/entity/user/user.dart';
import '../../../domain/entity/user_data/user.dart';
import '../../../domain/usecase/user/login_usecase.dart';

class UserRepositoryImpl extends UserRepository {
  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  UserRepositoryImpl(this._sharedPrefsHelper);

  // Login:---------------------------------------------------------------------
  @override
  Future<User?> login(LoginParams params) async {
    return null;
  }

  @override
  Future<void> saveIsLoggedIn(bool value) =>
      _sharedPrefsHelper.saveIsLoggedIn(value);

  @override
  Future<bool> get isLoggedIn => _sharedPrefsHelper.isLoggedIn;

  @override
  Future<UserData> getUserInfo() async {
    return UserData(
        id: '128736',
        name: 'Anh Long',
        email: 'anhlong@gmail.com',
        dob: '01/01/2003',
        password: '123456789' //encrypted
    );
  }

  @override
  Future<UserData> updateUserInfo(UserData newUser) {
    // TODO: implement updateUserInfo
    throw UnimplementedError();
  }
}
