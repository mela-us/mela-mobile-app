import 'dart:async';

import 'package:mela/domain/entity/user/user.dart';


abstract class UserRepository {
  Future<User> getUserInfo();

  Future<String> updateName(String name);
  Future<String> updateBirthday(String birthday);
  Future<String> updateImage(String image);

  Future<bool> logout();
}
