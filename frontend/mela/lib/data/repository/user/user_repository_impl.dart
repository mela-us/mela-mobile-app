import 'dart:async';

import 'package:mela/domain/repository/user/user_repository.dart';
import 'package:mela/data/sharedpref/shared_preference_helper.dart';

import '../../../domain/entity/user/user.dart';
import '../../../domain/entity/user/user.dart';

class UserRepositoryImpl extends UserRepository {
  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  UserRepositoryImpl(this._sharedPrefsHelper);

  // Login:---------------------------------------------------------------------

  @override
  Future<User> getUserInfo() async {
    return User(
        id: '128736',
        name: 'Anh Long',
        email: 'anhlong@gmail.com',
        dob: '01/01/2003',
        password: '123456789' //encrypted
    );
  }

  @override
  Future<User> updateUserInfo(User newUser) {
    // TODO: implement updateUserInfo
    throw UnimplementedError();
  }
  
}
