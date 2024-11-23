import 'dart:async';


import 'package:mela/domain/entity/user/user.dart';

import '../../usecase/user_login/login_usecase.dart';

abstract class UserLoginRepository {
  Future<User?> login(LoginParams params);

  Future<void> saveIsLoggedIn(bool value);

  Future<bool> get isLoggedIn;
}
