import 'dart:async';
import 'dart:io';

import 'package:mela/domain/entity/user/user.dart';


abstract class UserRepository {
  Future<User> getUserInfo();

  Future<String> updateName(String name);
  Future<String> updateBirthday(String birthday);

  Future<String> updateImage(File image, String urls);

  Future<String> getImageUpdatePresign();

  Future<bool> logout();

  Future<bool> deleteAccount();
}
