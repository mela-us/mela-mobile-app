import 'dart:async';

import 'package:mela/domain/entity/user/user.dart';


abstract class UserRepository {

  Future<User> getUserInfo();
  Future<User> updateUserInfo(User newUser);
}
