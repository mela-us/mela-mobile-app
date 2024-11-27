import 'dart:async';


import 'package:mela/domain/entity/user/token_model.dart';
import 'package:mela/domain/entity/user/user.dart';

import '../../usecase/user_login/login_usecase.dart';

abstract class UserLoginRepository {
  Future<TokenModel?> login(LoginParams params);

  Future<void> saveIsLoggedIn(bool value);

  Future<void> saveAccessToken(String accessToken);
  Future<void> saveRefreshToken(String refreshToken);

  Future<bool> get isLoggedIn;
}
