import 'dart:async';

import 'package:mela/domain/entity/user_data/user.dart';
import 'package:mela/domain/usecase/user/login_usecase.dart';

import '../../entity/user/user.dart';

abstract class UserRepository {
  Future<User?> login(LoginParams params);

  Future<void> saveIsLoggedIn(bool value);

  Future<bool> get isLoggedIn;

  Future<UserData> getUserInfo();
  Future<UserData> updateUserInfo(UserData newUser);
}
